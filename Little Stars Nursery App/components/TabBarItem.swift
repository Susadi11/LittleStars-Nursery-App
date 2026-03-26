//
//  TabBarItem.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-25.
//

import SwiftUI

struct TabBarItem: View {
    var icon: String
    var title: String
    var tab: String
    @Binding var selectedTab: String
    
    private let activeColor   = Color(red: 0.11, green: 0.56, blue: 0.53)
    private let activeBg      = Color(red: 0.68, green: 0.90, blue: 0.88)
    private let inactiveColor = Color(red: 0.55, green: 0.60, blue: 0.65)
    
    var isSelected: Bool { selectedTab == tab }
    
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
              
                Circle()
                    .fill(isSelected ? activeBg : Color.clear)
                    .frame(width: 56, height: 56)
                
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(isSelected ? activeColor : inactiveColor)
            }
            
            Text(title)
                .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? activeColor : inactiveColor)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        }
    }
}
