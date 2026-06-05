//
//  ProfileWeeklyReportCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI
import PDFKit

struct ProfileWeeklyReportCard: View {
    @State private var reportURL: URL?
    @State private var showPreview = false
    @State private var isGenerating = false

    var body: some View {
        Button {
            guard !isGenerating else { return }
            isGenerating = true
            Task.detached(priority: .userInitiated) {
                let url = savePDFToTemp()
                await MainActor.run {
                    reportURL     = url
                    isGenerating  = false
                    showPreview   = true
                }
            }
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.Theme.primary.opacity(0.12))
                        .frame(width: 44, height: 44)
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color.Theme.secondary)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text("Weekly Progress Report")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.Theme.labelPrimary)
                    Text("View and save this week's diary summary as PDF")
                        .font(.system(size: 11))
                        .foregroundColor(Color.Theme.labelSubtitle)
                }
                Spacer()
                if isGenerating {
                    ProgressView()
                        .tint(Color.Theme.secondary)
                } else {
                    Image(systemName: "arrow.down.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color.Theme.secondary)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        }
        .sheet(isPresented: $showPreview) {
            if let url = reportURL {
                PDFPreviewView(pdfURL: url)
            }
        }
    }

    private func savePDFToTemp() -> URL {
        let data = WeeklyReportGenerator.generate(
            childName: "Nethan Perera",
            entries: sampleDiaryEntries
        )
        let fileName = "Nethan_Weekly_Report_\(formattedDate()).pdf"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try? data.write(to: url)
        return url
    }

    private func formattedDate() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: Date())
    }
}

struct PDFPreviewView: View {
    let pdfURL: URL
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            PDFKitView(url: pdfURL)
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Weekly Report")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") { dismiss() }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        ShareLink(
                            item: pdfURL,
                            preview: SharePreview(
                                pdfURL.lastPathComponent,
                                image: Image(systemName: "doc.text.fill")
                            )
                        )
                    }
                }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView           = PDFView()
        pdfView.autoScales    = true
        pdfView.displayMode   = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document      = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
