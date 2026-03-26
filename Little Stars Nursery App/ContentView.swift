//
//  ContentView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "home"
    
    private let bgColor = Color(red: 0.97, green: 0.98, blue: 0.98) 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            bgColor.ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case "home":
                    PlaceholderView(title: "Home", icon: "house.fill")
                case "diary":
                    PlaceholderView(title: "Diary", icon: "calendar")
                case "track":
                    PlaceholderView(title: "Track", icon: "mappin.and.ellipse")
                case "menu":
                    PlaceholderView(title: "Menu", icon: "line.3.horizontal")
                default:
                    PlaceholderView(title: "Home", icon: "house.fill")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 100)
            
            CustomTabBar(selectedTab: $selectedTab)
                .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}


struct PlaceholderView: View {
    var title: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 52))
                .foregroundColor(Color(red: 0.18, green: 0.77, blue: 0.71))
            Text(title)
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(Color(red: 0.11, green: 0.56, blue: 0.53))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
