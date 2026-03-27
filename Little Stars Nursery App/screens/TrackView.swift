//
//  TrackView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-25.
//

import SwiftUI
import MapKit

struct TrackView: View {
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.500, longitude: -0.085),
        span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    )

    private let nurseryCoord = CLLocationCoordinate2D(latitude: 51.502, longitude: -0.092)
    private let busCoord     = CLLocationCoordinate2D(latitude: 51.498, longitude: -0.075)

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                Map(coordinateRegion: $region, annotationItems: mapAnnotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        if item.isNursery {
                            NurseryPin()
                        } else {
                            BusPin()
                        }
                    }
                }
                .ignoresSafeArea()

                DashedRouteLine()
                    .ignoresSafeArea()

                VStack {
                    AppHeaderView()
                        .background(Color.white.opacity(0.95))
                        .padding(.top, geo.safeAreaInsets.top)
                    Spacer()
                }
                .ignoresSafeArea(edges: .top)

                VStack(spacing: 0) {
                    Spacer()
                    TrackInfoCard()
  
                        .padding(.bottom, 83)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    var mapAnnotations: [MapPin] {
        [
            MapPin(coordinate: nurseryCoord, isNursery: true),
            MapPin(coordinate: busCoord,     isNursery: false)
        ]
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let isNursery: Bool
}

struct NurseryPin: View {
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(secondaryColor)
                    .frame(width: 46, height: 46)
                    .shadow(color: secondaryColor.opacity(0.4), radius: 6, x: 0, y: 3)
                Image(systemName: "house.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text("NURSERY")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(secondaryColor)
                .kerning(1.0)
                .padding(.horizontal, 9)
                .padding(.vertical, 4)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
        }
    }
}

struct BusPin: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        ZStack {
            Circle()
                .fill(primaryColor.opacity(0.25))
                .frame(width: 54, height: 54)
            Circle()
                .fill(primaryColor)
                .frame(width: 40, height: 40)
                .shadow(color: primaryColor.opacity(0.5), radius: 8, x: 0, y: 3)
            Image(systemName: "bus.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

struct DashedRouteLine: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        GeometryReader { geo in
            Path { path in
                let startX = geo.size.width  * 0.82
                let startY = geo.size.height * 0.38
                let endX   = geo.size.width  * 0.25
                let endY   = geo.size.height * 0.58
                path.move(to: CGPoint(x: startX, y: startY))
                path.addCurve(
                    to: CGPoint(x: endX, y: endY),
                    control1: CGPoint(x: startX - 80, y: startY + 30),
                    control2: CGPoint(x: endX + 100,  y: endY - 30)
                )
            }
            .stroke(primaryColor, style: StrokeStyle(lineWidth: 3, dash: [9, 7]))
        }
        .allowsHitTesting(false)
    }
}

struct TrackInfoCard: View {
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)
    private let chipBg         = Color(red: 0.93, green: 0.97, blue: 0.97)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("ON THE WAY")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(primaryColor)
                        .kerning(1.1)
                    Text("ETA 14:45")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 1) {
                    Text("Est. Arrival")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("12 mins")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                }
            }

            HStack(spacing: 10) {
                InfoChip(
                    icon: "person.fill",
                    label: "STAFF",
                    value: "Sarah J.",
                    bg: chipBg,
                    iconColor: primaryColor
                )
                InfoChip(
                    icon: "person.2.fill",
                    label: "GROUP",
                    value: "Foxes",
                    bg: chipBg,
                    iconColor: primaryColor
                )
            }

            Button(action: {}) {
                HStack(spacing: 10) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 15, weight: .semibold))
                    Text("Contact Supervisor")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(secondaryColor)
                .cornerRadius(30)
            }
        }
        .padding(18)
        .background(
            Color.white
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: -4)
        )
        .padding(.horizontal, 14)
    }
}

struct InfoChip: View {
    let icon: String
    let label: String
    let value: String
    let bg: Color
    let iconColor: Color

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.18))
                    .frame(width: 38, height: 38)
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundColor(iconColor)
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(label)
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.gray)
                    .kerning(0.8)
                Text(value)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bg)
        .cornerRadius(14)
    }
}

#Preview {
    TrackView()
}
