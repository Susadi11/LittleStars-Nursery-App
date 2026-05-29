//
//  ProfileMedicalCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileMedicalCard: View {
    @State private var isEditing    = false
    @State private var condition    = "Asthma"
    @State private var medication   = "Salbutamol inhaler (Blue)"
    @State private var bloodType    = "O Positive"
    @State private var gpName       = "Dr. Sharma, Highfield Surgery"
    @State private var nhsNumber    = "NHS 123 456 7890"

    var body: some View {
        ProfileInfoCard(title: "Medical Information", editAction: { isEditing.toggle() }) {
            VStack(alignment: .leading, spacing: 12) {

                if isEditing {
                    ProfileEditField(label: "Medical Condition", value: $condition,  icon: "heart.fill")
                    ProfileEditField(label: "Medication",        value: $medication, icon: "pills.fill")
                    ProfileEditField(label: "Blood Type",        value: $bloodType,  icon: "drop.fill")
                    ProfileEditField(label: "GP",                value: $gpName,     icon: "stethoscope")
                    ProfileEditField(label: "NHS Number",        value: $nhsNumber,  icon: "number")

                    HStack {
                        Button("Cancel") { isEditing = false }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.labelAsh)
                        Spacer()
                        Button("Save") { isEditing = false }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.secondary)
                    }
                    .padding(.top, 4)

                } else {
                    ProfileDetailRow(label: "Medical Condition", value: condition,  icon: "heart.fill")
                    ProfileDetailRow(label: "Medication",        value: medication, icon: "pills.fill")
                    ProfileDetailRow(label: "Blood Type",        value: bloodType,  icon: "drop.fill")
                    ProfileDetailRow(label: "GP",                value: gpName,     icon: "stethoscope")
                    ProfileDetailRow(label: "NHS Number",        value: nhsNumber,  icon: "number")

                    HStack(spacing: 8) {
                        Image(systemName: "cross.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color.Theme.secondary)
                        Text("EpiPen protocol on file — see documents")
                            .font(.system(size: 12))
                            .foregroundColor(Color.Theme.labelSubtitle)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color.Theme.primary.opacity(0.08))
                    .cornerRadius(10)
                }
            }
        }
    }
}
