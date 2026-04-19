//
//  DiaryView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//
import SwiftUI

struct DiaryView: View {
    @State private var isLoading = false
    @State private var entries: [DiaryEntry] = []

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

                    if isLoading {
                        VStack(spacing: 14) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.Theme.primary))
                                .scaleEffect(1.3)
                            Text("Loading diary...")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 60)
                    } else if entries.isEmpty {
                        DiaryEmptyState()
                            .padding(.horizontal, 16)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                                DiaryTimelineRow(
                                    entry: entry,
                                    isLast: index == entries.count - 1
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    Spacer().frame(height: 110)
                }
            }
        }
        .onAppear {
            Task { await loadDiary() }
        }
    }

    private func loadDiary() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 800_000_000)
        entries = sampleDiaryEntries
        isLoading = false
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
