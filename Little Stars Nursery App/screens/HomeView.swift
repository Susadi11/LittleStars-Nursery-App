//
//  HomeView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.Theme.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    AppHeaderView()

                    VStack(spacing: 16) {
                        NurseryTourCard()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)

                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

private struct NurseryTourCard: View {
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.Theme.primary.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "visionpro")
                    .font(.system(size: 24))
                    .foregroundColor(Color.Theme.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Explore Our Nursery")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.Theme.labelPrimary)
                Text("Available on Apple Vision Pro")
                    .font(.system(size: 12))
                    .foregroundColor(Color.Theme.labelSubtitle)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(Color.Theme.labelChevron)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
