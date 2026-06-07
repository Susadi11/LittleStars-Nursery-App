//
//  ContentView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-24.
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home    = "Home"
    case diary   = "Diary"
    case chat    = "Chat"
    case track   = "Track"
    case profile = "Profile"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:    return "house.fill"
        case .diary:   return "calendar"
        case .chat:    return "bubble.left.fill"
        case .track:   return "mappin.and.ellipse"
        case .profile: return "person.fill"
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedTab: AppTab? = .home
    @State private var selectedTabIndex = 0

    init() {
        UITabBar.appearance().tintColor = UIColor(Color.Theme.secondary)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.Theme.labelCaption)
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        if horizontalSizeClass == .regular {
            iPadLayout
        } else {
            iPhoneLayout
        }
    }

    // MARK: iPad — NavigationSplitView with sidebar
    private var iPadLayout: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Text("NurseryConnect")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color.Theme.labelPrimary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                List(AppTab.allCases, selection: $selectedTab) { tab in
                    Label(tab.rawValue, systemImage: tab.icon)
                        .tag(tab)
                        .font(.system(size: 15, weight: .medium))
                }
                .listStyle(.sidebar)
            }
            .background(Color.white)
            .navigationBarHidden(true)
        } detail: {
            destinationView(for: selectedTab ?? .home)
        }
        .tint(Color.Theme.secondary)
    }

    // MARK: iPhone — TabView
    private var iPhoneLayout: some View {
        TabView(selection: $selectedTabIndex) {
            HomeView()
                .tabItem { Label("Home",    systemImage: "house.fill") }
                .tag(0)
            DiaryView()
                .tabItem { Label("Diary",   systemImage: "calendar") }
                .tag(1)
            ChatView()
                .tabItem { Label("Chat",    systemImage: "bubble.left.fill") }
                .tag(2)
            TrackView()
                .tabItem { Label("Track",   systemImage: "mappin.and.ellipse") }
                .tag(3)
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(4)
        }
        .accentColor(Color.Theme.secondary)
    }

    @ViewBuilder
    private func destinationView(for tab: AppTab) -> some View {
        switch tab {
        case .home:    HomeView()
        case .diary:   DiaryView()
        case .chat:    ChatView()
        case .track:   TrackView()
        case .profile: ProfileView()
        }
    }
}
