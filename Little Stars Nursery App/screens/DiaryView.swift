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

                    VStack(spacing: 0) {
                        ForEach(Array(sampleDiaryEntries.enumerated()), id: \.element.id) { index, entry in
                            DiaryTimelineRow(
                                entry: entry,
                                isLast: index == sampleDiaryEntries.count - 1
                            )
                        }
                    }
                    .padding(.horizontal, 16)

                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

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

struct DiaryEntryCard: View {
    let entry: DiaryEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Text(entry.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.Theme.secondary)
                    .kerning(0.8)
                Spacer()
                Text(entry.time)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Text(entry.description)
                .font(.system(size: 15))
                .foregroundColor(Color.Theme.labelBody)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            if let name = entry.imageName, let _ = UIImage(named: name) {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    DiaryView()
}
