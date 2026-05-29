//
//  ProfileChildHeaderCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI
import PhotosUI

struct ProfileChildHeaderCard: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var childImage: Image?

    var body: some View {
        VStack(spacing: 0) {

            // Child photo with PhotosUI picker
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                Group {
                    if let childImage {
                        childImage
                            .resizable()
                            .scaledToFill()
                    } else if UIImage(named: "profilePic") != nil {
                        Image("profilePic")
                            .resizable()
                            .scaledToFill()
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.Theme.primary.opacity(0.18))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 38))
                                    .foregroundColor(Color.Theme.secondary)
                            )
                    }
                }
                .frame(width: 82, height: 82)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.10), radius: 8, x: 0, y: 3)
            }
            .onChange(of: selectedPhoto) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        childImage = Image(uiImage: uiImage)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 10)

            // Name, age, room
            VStack(spacing: 5) {
                Text("Nethan Perera")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color.Theme.labelPrimary)
                Text("Age 3  •  Sunshine Room")
                    .font(.system(size: 13))
                    .foregroundColor(Color.Theme.labelSubtitle)
            }
            .padding(.bottom, 18)

            // Stats row
            HStack(spacing: 0) {
                ProfileStatItem(value: "14",       label: "Weeks Enrolled", icon: "calendar")
                Divider().frame(height: 36)
                ProfileStatItem(value: "Olivia M.", label: "Keyworker",     icon: "person.fill")
                Divider().frame(height: 36)
                ProfileStatItem(value: "Full Day",  label: "Session",       icon: "clock.fill")
            }
            .padding(.vertical, 14)
            .background(Color.white)
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }
}

struct ProfileStatItem: View {
    let value: String
    let label: String
    let icon: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 13))
                .foregroundColor(Color.Theme.secondary)
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color.Theme.labelPrimary)
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(Color.Theme.labelCaption)
        }
        .frame(maxWidth: .infinity)
    }
}
