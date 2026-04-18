//
//  DiaryTimelineRow.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-02.
//

import SwiftUI

struct DiaryTimelineRow: View {
    let entry: DiaryEntry
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(entry.category.color)
                        .frame(width: 48, height: 48)
                    Image(systemName: entry.category.icon)
                        .font(.system(size: 19, weight: .medium))
                        .foregroundColor(.white)
                }
                if !isLast {
                    Rectangle()
                        .fill(Color.Theme.diaryLine)
                        .frame(width: 2)
                        .frame(minHeight: 40)
                }
            }
            .frame(width: 48)

            DiaryEntryCard(entry: entry)
                .padding(.leading, 14)
                .padding(.bottom, isLast ? 0 : 16)
        }
    }
}
