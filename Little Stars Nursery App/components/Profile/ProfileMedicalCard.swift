//
//  ProfileMedicalCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileMedicalCard: View {
    @State private var isEditing = false

    @AppStorage("medical.condition")  private var condition  = "Asthma"
    @AppStorage("medical.medication") private var medication = "Salbutamol inhaler (Blue)"
    @AppStorage("medical.bloodType")  private var bloodType  = "O Positive"
    @AppStorage("medical.gpName")     private var gpName     = "Dr. Sharma, Highfield Surgery"
    @AppStorage("medical.nhsNumber")  private var nhsNumber  = "NHS 123 456 7890"

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
                            .keyboardShortcut(.escape, modifiers: [])
                        Spacer()
                        Button("Save") { isEditing = false }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.secondary)
                            .keyboardShortcut("s", modifiers: .command)
                    }
                    .padding(.top, 4)

                } else {
                    ProfileDetailRow(label: "Medical Condition", value: condition,  icon: "heart.fill")
                    ProfileDetailRow(label: "Medication",        value: medication, icon: "pills.fill")
                    ProfileDetailRow(label: "Blood Type",        value: bloodType,  icon: "drop.fill")
                    ProfileDetailRow(label: "GP",                value: gpName,     icon: "stethoscope")
                    ProfileDetailRow(label: "NHS Number",        value: nhsNumber,  icon: "number")

                }
            }
        }
    }
}
