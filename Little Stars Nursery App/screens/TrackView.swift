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
        center: CLLocationCoordinate2D(latitude: 6.8420, longitude: 80.0750),
        span: MKCoordinateSpan(latitudeDelta: 0.030, longitudeDelta: 0.030)
    )

    private let nurseryCoord = CLLocationCoordinate2D(latitude: 6.8455, longitude: 80.0798)
    private let homeCoord    = CLLocationCoordinate2D(latitude: 6.8389, longitude: 80.0701)

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                Map(coordinateRegion: $region, annotationItems: mapAnnotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        if item.type == .nursery {
                            NurseryPin()
                        } else if item.type == .bus {
                            BusPin()
                        } else {
                            HomePin()
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
                    TrackInfoBar()
                        .padding(.bottom, 83)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    var mapAnnotations: [MapPin] {
        [
            MapPin(coordinate: nurseryCoord, type: .nursery),
            MapPin(coordinate: homeCoord,    type: .home),
            MapPin(
                coordinate: CLLocationCoordinate2D(latitude: 6.8415, longitude: 80.0748),
                type: .bus
            )
        ]
    }
}

enum PinType { case nursery, bus, home }

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let type: PinType
}

struct NurseryPin: View {
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        VStack(spacing: 3) {
            ZStack {
                Circle()
                    .fill(secondaryColor)
                    .frame(width: 44, height: 44)
                    .shadow(color: secondaryColor.opacity(0.4), radius: 6, x: 0, y: 3)
                Image(systemName: "building.2.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text("NURSERY")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(secondaryColor)
                .kerning(0.8)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.10), radius: 3, x: 0, y: 1)
        }
    }
}

struct HomePin: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        VStack(spacing: 3) {
            ZStack {
                Circle()
                    .fill(primaryColor.opacity(0.20))
                    .frame(width: 44, height: 44)
                Circle()
                    .fill(primaryColor)
                    .frame(width: 32, height: 32)
                    .shadow(color: primaryColor.opacity(0.4), radius: 5, x: 0, y: 2)
                Image(systemName: "house.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text("HOME")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(primaryColor)
                .kerning(0.8)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.10), radius: 3, x: 0, y: 1)
        }
    }
}

struct BusPin: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        ZStack {
            Circle()
                .fill(primaryColor.opacity(0.22))
                .frame(width: 52, height: 52)
            Circle()
                .fill(primaryColor)
                .frame(width: 38, height: 38)
                .shadow(color: primaryColor.opacity(0.5), radius: 8, x: 0, y: 3)
            Image(systemName: "bus.fill")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

struct DashedRouteLine: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        GeometryReader { geo in
            Path { path in
                let startX = geo.size.width  * 0.28
                let startY = geo.size.height * 0.62
                let endX   = geo.size.width  * 0.60
                let endY   = geo.size.height * 0.36
                path.move(to: CGPoint(x: startX, y: startY))
                path.addCurve(
                    to: CGPoint(x: endX, y: endY),
                    control1: CGPoint(x: startX + 60, y: startY - 40),
                    control2: CGPoint(x: endX - 60,   y: endY + 40)
                )
            }
            .stroke(primaryColor, style: StrokeStyle(lineWidth: 2.5, dash: [8, 6]))
        }
        .allowsHitTesting(false)
    }
}

struct TrackInfoBar: View {
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        HStack(spacing: 0) {

            VStack(alignment: .leading, spacing: 1) {
                Text("ON THE WAY")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(primaryColor)
                    .kerning(0.8)
                Text("ETA 14:45")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
            }

            Spacer()

            Rectangle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 1, height: 36)

            Spacer()

            VStack(alignment: .center, spacing: 1) {
                Text("Est. Arrival")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                Text("12 mins")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
            }

            Spacer()

            Rectangle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 1, height: 36)

            Spacer()

            HStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(primaryColor.opacity(0.18))
                        .frame(width: 30, height: 30)
                    Image(systemName: "person.fill")
                        .font(.system(size: 12))
                        .foregroundColor(primaryColor)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("STAFF")
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundColor(.gray)
                        .kerning(0.5)
                    Text("Ayesha")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                }
            }

            Spacer()

            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(secondaryColor)
                        .frame(width: 40, height: 40)
                    Image(systemName: "phone.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            ZStack {
                Color.white.opacity(0.25)
                Color(red: 0.97, green: 0.99, blue: 0.99).opacity(0.55)
            }
        )
        .background(.ultraThinMaterial)
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: -2)
        .padding(.horizontal, 14)
    }
}

#Preview {
    TrackView()
}
