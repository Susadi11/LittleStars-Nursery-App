//
//  ProfilePersonalInfoCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfilePersonalInfoCard: View {
    @State private var isEditing = false

    @AppStorage("profile.fullName")      private var fullName      = "Nethan Kusal Perera"
    @AppStorage("profile.preferredName") private var preferredName = "Nethan"
    @AppStorage("profile.nationality")   private var nationality   = "Sri Lankan"
    @AppStorage("profile.address")       private var address       = "24 Maple Close, London, E4 7NG"

    private let dob = "12 March 2022  •  Age 3"

    var body: some View {
        ProfileInfoCard(title: "Personal Information", editAction: { isEditing.toggle() }) {
            VStack(alignment: .leading, spacing: 12) {

                if isEditing {
                    ProfileEditField(label: "Full Name",      value: $fullName,      icon: "person.fill")
                    ProfileEditField(label: "Preferred Name", value: $preferredName, icon: "textformat")
                    ProfileDetailRow(label: "Date of Birth",  value: dob,            icon: "gift.fill")
                    ProfileEditField(label: "Nationality",    value: $nationality,   icon: "globe")
                    ProfileEditField(label: "Home Address",   value: $address,       icon: "house.fill")

                    HStack {
                        Button("Cancel") { isEditing = false }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.labelAsh)
                            .keyboardShortcut(.escape, modifiers: [])
                        Spacer()
                        Button("Save") { isEditing = false }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.secondary)
                            .keyboardShortcut("s", modifiers: .command)
                    }
                    .padding(.top, 4)

                } else {
                    ProfileDetailRow(label: "Full Name",      value: fullName,      icon: "person.fill")
                    ProfileDetailRow(label: "Preferred Name", value: preferredName, icon: "textformat")
                    ProfileDetailRow(label: "Date of Birth",  value: dob,           icon: "gift.fill")
                    ProfileDetailRow(label: "Nationality",    value: nationality,   icon: "globe")
                    ProfileDetailRow(label: "Home Address",   value: address,       icon: "house.fill")
                }
            }
        }
    }
}
