//
//  DiaryView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//

import SwiftUI

struct DiaryView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.Theme.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    AppHeaderView()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nethan's Diary")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color.Theme.labelPrimary)

                        Text("THURSDAY, OCTOBER 24")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                            .kerning(1.2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 28)

                    if sampleDiaryEntries.isEmpty {
                        DiaryEmptyState()
                            .padding(.horizontal, 16)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(Array(sampleDiaryEntries.enumerated()), id: \.element.id) { index, entry in
                                DiaryTimelineRow(
                                    entry: entry,
                                    isLast: index == sampleDiaryEntries.count - 1
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Spacer().frame(height: 110)
                }
            }
        }
    }
}


struct DiaryEmptyState: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 48))
                .foregroundColor(Color.Theme.primary.opacity(0.5))
            Text("No Diary Entries Yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.Theme.labelPrimary)
            Text("Nethan's keyworker hasn't added any entries for today yet. Check back later!")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    DiaryView()
}
