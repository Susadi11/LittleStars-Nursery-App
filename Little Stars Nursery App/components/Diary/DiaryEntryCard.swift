//
//  DiaryEntryCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-02.
//

import SwiftUI

struct DiaryEntryCard: View {
    let entry: DiaryEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Text(entry.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.Theme.secondary)
                    .kerning(0.8)
                Spacer()
                Text(entry.time)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Text(entry.description.isEmpty ? "No details recorded for this entry." : entry.description)
                .font(.system(size: 15))
                .foregroundColor(entry.description.isEmpty ? Color.Theme.labelCaption : Color.Theme.labelBody)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            if let name = entry.imageName, let _ = UIImage(named: name) {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
