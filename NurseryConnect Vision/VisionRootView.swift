//
//  VisionRootView.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

struct VisionRootView: View {
    private let child: VisionChild = .harry

    var body: some View {
        VisionMealDashboardView(child: child)
            .ornament(
                visibility: .visible,
                attachmentAnchor: .scene(.top)
            ) {
                BusTrackerOrnament()
                    .frame(width: 700, height: 90)
                    .padding(.bottom, 80)
            }
    }
}
