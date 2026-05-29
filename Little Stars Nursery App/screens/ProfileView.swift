//
//  ProfileView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-01.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.Theme.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    AppHeaderView()

                    ProfileChildHeaderCard()
                        .padding(.top, 8)

                    VStack(spacing: 12) {
                        ProfileSectionLabel(title: "CHILD PROFILE")
                        ProfilePersonalInfoCard()
                        ProfileFamilyCard()

                        ProfileSectionLabel(title: "HEALTH & WELFARE")
                        ProfileMedicalCard()
                        ProfileAllergenCard()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)

                    ProfileAccountSettingsCard()

                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
