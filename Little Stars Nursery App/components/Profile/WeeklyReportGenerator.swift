//
//  WeeklyReportGenerator.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-06-02.
//

import UIKit
import PDFKit

struct WeeklyReportGenerator {

    static func generate(childName: String, entries: [DiaryEntry]) -> Data {
        let pageWidth: CGFloat  = 595
        let pageHeight: CGFloat = 842
        let margin: CGFloat     = 44
        let renderer = UIGraphicsPDFRenderer(
            bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        )

        return renderer.pdfData { ctx in
            ctx.beginPage()
            var y: CGFloat = margin

            let headerRect = CGRect(x: 0, y: 0, width: pageWidth, height: 80)
            UIColor(red: 0.20, green: 0.60, blue: 0.55, alpha: 1).setFill()
            UIRectFill(headerRect)

            let titleAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor: UIColor.white
            ]
            "Little Stars Nursery".draw(at: CGPoint(x: margin, y: 20), withAttributes: titleAttr)

            let subAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 11),
                .foregroundColor: UIColor.white.withAlphaComponent(0.85)
            ]
            "Weekly Progress Report".draw(at: CGPoint(x: margin, y: 48), withAttributes: subAttr)

            y = 100

            let nameAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                .foregroundColor: UIColor.darkText
            ]
            "\(childName)'s Weekly Summary".draw(at: CGPoint(x: margin, y: y), withAttributes: nameAttr)
            y += 22

            let weekAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 11),
                .foregroundColor: UIColor.gray
            ]
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            "Report generated: \(formatter.string(from: Date()))".draw(
                at: CGPoint(x: margin, y: y), withAttributes: weekAttr)
            y += 28

            UIColor(red: 0.20, green: 0.60, blue: 0.55, alpha: 0.4).setFill()
            UIRectFill(CGRect(x: margin, y: y, width: pageWidth - margin * 2, height: 1))
            y += 16

            let labelAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10, weight: .bold),
                .foregroundColor: UIColor(red: 0.20, green: 0.60, blue: 0.55, alpha: 1)
            ]
            let timeAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.gray
            ]
            let bodyAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.darkText
            ]

            for entry in entries {
                if y > pageHeight - 100 {
                    ctx.beginPage()
                    y = margin
                }

                // Category label + time
                entry.title.draw(at: CGPoint(x: margin, y: y), withAttributes: labelAttr)
                let timeStr = "  \(entry.time)"
                let timeWidth = (entry.title as NSString).size(withAttributes: labelAttr).width
                timeStr.draw(at: CGPoint(x: margin + timeWidth, y: y), withAttributes: timeAttr)
                y += 16

                // Description — wrapped
                let descRect = CGRect(x: margin, y: y,
                                      width: pageWidth - margin * 2, height: 200)
                let descStr = NSString(string: entry.description)
                let boundingBox = descStr.boundingRect(
                    with: CGSize(width: pageWidth - margin * 2, height: 200),
                    options: .usesLineFragmentOrigin,
                    attributes: bodyAttr, context: nil)
                descStr.draw(in: descRect, withAttributes: bodyAttr)
                y += boundingBox.height + 14

                // Separator
                UIColor.lightGray.withAlphaComponent(0.4).setFill()
                UIRectFill(CGRect(x: margin, y: y, width: pageWidth - margin * 2, height: 0.5))
                y += 12
            }

            let footerY = pageHeight - 36
            let footerAttr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 9),
                .foregroundColor: UIColor.gray
            ]
            UIColor.lightGray.withAlphaComponent(0.5).setFill()
            UIRectFill(CGRect(x: margin, y: footerY - 8, width: pageWidth - margin * 2, height: 0.5))
            "Little Stars Nursery & Daycare  •  Confidential — GDPR Compliant"
                .draw(at: CGPoint(x: margin, y: footerY), withAttributes: footerAttr)
        }
    }
}
