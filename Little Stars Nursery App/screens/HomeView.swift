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
                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
