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
            Spacer()
            TabBarItem(icon: "house.fill", title: "Home", tab: "home", selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "calendar", title: "Diary", tab: "diary", selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "mappin.and.ellipse", title: "Track", tab: "track", selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "line.3.horizontal", title: "Menu", tab: "menu", selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.top, 8)
        .background(Color.white)
        .clipShape(
       
            UnevenRoundedRectangle(
                topLeadingRadius: 28,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 28
            )
        )
        .shadow(color: Color(red: 0.11, green: 0.56, blue: 0.53).opacity(0.15), radius: 12, x: 0, y: -4)
    }
}
