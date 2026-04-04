//
//  ContentView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    init() {
        UITabBar.appearance().tintColor = UIColor(red: 0.11, green: 0.56, blue: 0.53, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.55, green: 0.60, blue: 0.65, alpha: 1)
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            DiaryView()
                .tabItem { Label("Diary", systemImage: "calendar") }
                .tag(1)

            ChatView()
                .tabItem { Label("Chat", systemImage: "bubble.left.fill") }
                .tag(2)

            TrackView()
                .tabItem { Label("Track", systemImage: "mappin.and.ellipse") }
                .tag(3)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(4)
        }
        .accentColor(Color(red: 0.11, green: 0.56, blue: 0.53))
    }
}
