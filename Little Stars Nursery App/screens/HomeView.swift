//
//  HomeView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//

import SwiftUI

struct HomeView: View {
    private let bgColor = Color(red: 0.97, green: 0.98, blue: 0.98)
    
    var body: some View {
        ZStack(alignment: .top) {
            bgColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    AppHeaderView()
                }
            }
        }
    }
}

#Preview {
    DiaryView()
}
