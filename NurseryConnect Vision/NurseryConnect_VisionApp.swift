//
//  NurseryConnect_VisionApp.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

@main
struct NurseryConnect_VisionApp: App {
    var body: some Scene {
        WindowGroup {
            VisionRootView()
                .frame(minWidth: 900, minHeight: 600)
        }
        .windowStyle(.plain)
    }
}
