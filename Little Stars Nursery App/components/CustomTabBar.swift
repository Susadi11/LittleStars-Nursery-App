//
//  CustomTabBar.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            TabBarItem(icon: "house.fill", title: "Home", tab: "home", selectedTab: $selectedTab)
            TabBarItem(icon: "book.fill", title: "Diary", tab: "diary", selectedTab: $selectedTab)
            TabBarItem(icon: "location.fill", title: "Track", tab: "track", selectedTab: $selectedTab)
            TabBarItem(icon: "line.3.horizontal", title: "Menu", tab: "menu", selectedTab: $selectedTab)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(25)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
    }
}

