//
//  ProfileFamilyCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileFamilyCard: View {

    var body: some View {
        ProfileInfoCard(title: "Family & Emergency Contacts") {
            VStack(alignment: .leading, spacing: 14) {

                ProfileContactRow(
                    name: "Nathali Perera",
                    relationship: "MOTHER",
                    phone: "+94 77 123 4567",
                    isPrimary: true,
                    accentColor: Color.Theme.secondary,
                    imageName: "profilePic"
                )

                Divider()

                ProfileContactRow(
                    name: "Nadan Perera",
                    relationship: "FATHER",
                    phone: "+94 71 415 1567",
                    isPrimary: false,
                    accentColor: Color.Theme.labelAsh,
                    imageName: "father"
                )

                Divider()

                ProfileContactRow(
                    name: "Kumari Silva",
                    relationship: "GRANDMOTHER",
                    phone: "+94 77 987 6543",
                    isPrimary: false,
                    accentColor: Color(red: 0.55, green: 0.35, blue: 0.78),
                    imageName: "grand_mom"
                )

            }
        }
    }
}

struct ProfileContactRow: View {
    let name: String
    let relationship: String
    let phone: String
    let isPrimary: Bool
    let accentColor: Color
    var imageName: String? = nil

    var body: some View {
        HStack(spacing: 12) {

            ZStack {
                if let imgName = imageName, UIImage(named: imgName) != nil {
                    Image(imgName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(accentColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    Text(String(name.prefix(1)))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(accentColor)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.Theme.labelPrimary)
                    if isPrimary {
                        Text("PRIMARY")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(Color.Theme.secondary)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.Theme.primary.opacity(0.10))
                            .cornerRadius(4)
                    }
                }
                HStack(spacing: 6) {
                    Text(relationship)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(accentColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(accentColor.opacity(0.10))
                        .cornerRadius(4)
                    Text(phone)
                        .font(.system(size: 12))
                        .foregroundColor(Color.Theme.labelSubtitle)
                }
            }

            Spacer()

            ZStack {
                Circle()
                    .fill(Color.Theme.primary.opacity(0.10))
                    .frame(width: 34, height: 34)
                Image(systemName: "phone.fill")
                    .font(.system(size: 13))
                    .foregroundColor(Color.Theme.secondary)
            }
        }
    }
}
