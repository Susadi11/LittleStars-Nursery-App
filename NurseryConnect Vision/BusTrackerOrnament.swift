//
//  BusTrackerOrnament.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI
import Combine

struct BusTrackerOrnament: View {
    @State private var route: VisionRoute   = .liveRoute
    @State private var busXPosition: CGFloat = 0.0
    @State private var pulseScale: CGFloat   = 1.0
    @State private var isBusInTransit: Bool  = false
    @State private var allCollected: Bool    = false

    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 20) {
            busIconSection
            routeStripSection
            etaBadgeSection
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.08, green: 0.08, blue: 0.12).opacity(0.94))
        )
        .onAppear {
            if let first = route.stops.first {
                busXPosition = CGFloat(first.routePosition)
            }
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                pulseScale = 1.35
            }
        }
        .onReceive(timer) { _ in
            advanceBusState()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }

    private var busIconSection: some View {
        VStack(spacing: 4) {
            Image(systemName: "bus.fill")
                .font(.system(size: 22))
                .foregroundStyle(.indigo)
                .scaleEffect(isBusInTransit ? 1.1 : 1.0)
                .animation(
                    isBusInTransit
                        ? .easeInOut(duration: 0.5).repeatForever(autoreverses: true)
                        : .default,
                    value: isBusInTransit
                )
            Text("Nursery Van")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private var routeStripSection: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: 2)
                    .padding(.top, 18)

                ForEach(Array(route.stops.enumerated()), id: \.element.id) { index, stop in
                    stopMarker(for: stop, totalWidth: geo.size.width)
                }

                Image(systemName: "bus.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(Circle().fill(Color.indigo))
                    .offset(x: busXPosition * (geo.size.width - 24) - 12, y: 10)
                    .animation(.easeInOut(duration: 3.0), value: busXPosition)
            }
        }
        .frame(height: 60)
        .frame(maxWidth: 420)
    }

    private func stopMarker(for stop: VisionBusStop, totalWidth: CGFloat) -> some View {
        let xPos = CGFloat(stop.routePosition) * (totalWidth - 24)
        return VStack(spacing: 4) {
            Circle()
                .fill(stop.status == .upcoming ? Color.clear : Color.indigo)
                .overlay(
                    Circle()
                        .stroke(Color.indigo, lineWidth: stop.status == .upcoming ? 2 : 0)
                        .scaleEffect(stop.status == .current ? pulseScale : 1.0)
                )
                .frame(width: 16, height: 16)
            Text(stop.schoolName)
                .font(.system(size: 9))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 70)
            Text(stop.scheduledTime)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(.primary)
        }
        .offset(x: xPos - 8, y: -4)
    }

    private var etaBadgeSection: some View {
        VStack(spacing: 4) {
            Text(allCollected ? "Arrived" : "ETA")
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(allCollected ? "✓" : route.estimatedReturnTime)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(allCollected ? .green : .primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(allCollected
                              ? Color.green.opacity(0.15)
                              : Color.indigo.opacity(0.15))
                )
        }
    }

    private func advanceBusState() {
        guard !allCollected else { return }
        guard route.currentStopIndex < route.stops.count else {
            withAnimation { allCollected = true }
            return
        }

        let idx = route.currentStopIndex

        if route.stops[idx].status == .current {
            withAnimation(.easeInOut(duration: 0.4)) {
                route.stops[idx].status = .collected
                route.currentStopIndex += 1
            }
            let nextIdx = route.currentStopIndex
            if nextIdx < route.stops.count {
                isBusInTransit = true
                withAnimation(.easeInOut(duration: 3.0)) {
                    busXPosition = CGFloat(route.stops[nextIdx].routePosition)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isBusInTransit = false
                    withAnimation { route.stops[nextIdx].status = .current }
                    pulseScale = 1.0
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        pulseScale = 1.35
                    }
                }
            } else {
                withAnimation(.easeInOut(duration: 2.0)) {
                    busXPosition = 1.0
                    allCollected = true
                }
            }
        } else if route.stops[idx].status == .upcoming {
            withAnimation { route.stops[idx].status = .current }
        }
    }
}
