//
//  DiaryView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//

import SwiftUI

struct DiaryEntry: Identifiable {
    let id = UUID()
    let category: DiaryCategory
    let time: String
    let title: String
    let description: String
    let imageName: String?
}

enum DiaryCategory: String {
    case mood    = "Arrival Mood"
    case snack   = "Morning Snack"
    case play    = "Creative Play"
    case nap     = "Nap Time"
    case lunch   = "Lunch"
    case nappy   = "Nappy Log"
    case outdoor = "Outdoor Play"
    case pickup  = "Pick-Up Mood"
    
    var icon: String {
        switch self {
        case .mood:    return "face.smiling.fill"
        case .snack:   return "fork.knife"
        case .play:    return "paintpalette.fill"
        case .nap:     return "moon.zzz.fill"
        case .lunch:   return "takeoutbag.and.cup.and.straw.fill"
        case .nappy:   return "drop.fill"
        case .outdoor: return "sun.max.fill"
        case .pickup:  return "figure.wave"
        }
    }
    
    var color: Color {
        let p = Color(red: 0.18, green: 0.77, blue: 0.71)
        let s = Color(red: 0.11, green: 0.56, blue: 0.53)
        switch self {
        case .mood:    return p
        case .snack:   return p.opacity(0.75)
        case .play:    return s
        case .nap:     return Color(red: 0.66, green: 0.86, blue: 0.88)
        case .lunch:   return p
        case .nappy:   return Color(red: 0.40, green: 0.75, blue: 0.80)
        case .outdoor: return s.opacity(0.75)
        case .pickup:  return p.opacity(0.65)
        }
    }
}

let sampleDiaryEntries: [DiaryEntry] = [
    DiaryEntry(
        category: .mood,
        time: "08:30 AM",
        title: "ARRIVAL MOOD",
        description: "Leo arrived with a big smile and was excited to see his friends in the sensory corner.",
        imageName: nil
    ),
    DiaryEntry(
        category: .snack,
        time: "10:15 AM",
        title: "MORNING SNACK",
        description: "Enjoyed sliced organic pears and a small portion of whole-wheat crackers. Finished everything!",
        imageName: nil
    ),
    DiaryEntry(
        category: .play,
        time: "11:30 AM",
        title: "CREATIVE PLAY",
        description: "Leo explored finger painting today. He was very focused on mixing blue and yellow to make green.",
        imageName: "image1"
    ),
    DiaryEntry(
        category: .nap,
        time: "12:45 PM",
        title: "NAP TIME",
        description: "Fell asleep quickly and had a restful nap. Woke up happy and refreshed after about 90 minutes.",
        imageName: nil
    ),
    DiaryEntry(
        category: .lunch,
        time: "02:00 PM",
        title: "LUNCH",
        description: "Had pasta with tomato sauce and steamed broccoli. Ate well and tried a new vegetable today!",
        imageName: nil
    ),
    DiaryEntry(
        category: .nappy,
        time: "02:45 PM",
        title: "NAPPY LOG",
        description: "Nappy change after lunch — all normal. Dry by end of afternoon session.",
        imageName: nil
    ),
    DiaryEntry(
        category: .outdoor,
        time: "03:30 PM",
        title: "OUTDOOR PLAY",
        description: "Leo loved the sandbox today and made a castle with his best friend Mia. Great social interaction!",
        imageName: "child_drawing"
    ),
    DiaryEntry(
        category: .pickup,
        time: "05:00 PM",
        title: "PICK-UP MOOD",
        description: "Leo was in great spirits at pick-up, chatting about his painting and showing mum his green creation.",
        imageName: nil
    )
]

struct DiaryView: View {
    private let bgColor = Color(red: 0.97, green: 0.98, blue: 0.98)
    
    var body: some View {
        ZStack(alignment: .top) {
            bgColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    AppHeaderView()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Leo's Diary")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.18))
                        
                        Text("THURSDAY, OCTOBER 24")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                            .kerning(1.2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 28)
                    
                    VStack(spacing: 0) {
                        ForEach(Array(sampleDiaryEntries.enumerated()), id: \.element.id) { index, entry in
                            DiaryTimelineRow(
                                entry: entry,
                                isLast: index == sampleDiaryEntries.count - 1
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

struct DiaryTimelineRow: View {
    let entry: DiaryEntry
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(entry.category.color)
                        .frame(width: 48, height: 48)
                    Image(systemName: entry.category.icon)
                        .font(.system(size: 19, weight: .medium))
                        .foregroundColor(.white)
                }
                if !isLast {
                    Rectangle()
                        .fill(Color(red: 0.68, green: 0.90, blue: 0.88))
                        .frame(width: 2)
                        .frame(minHeight: 40)
                }
            }
            .frame(width: 48)

            DiaryEntryCard(entry: entry)
                .padding(.leading, 14)
                .padding(.bottom, isLast ? 0 : 16)
        }
    }
}

struct DiaryEntryCard: View {
    let entry: DiaryEntry
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Text(entry.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(secondaryColor)
                    .kerning(0.8)
                Spacer()
                Text(entry.time)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Text(entry.description)
                .font(.system(size: 15))
                .foregroundColor(Color(red: 0.20, green: 0.22, blue: 0.25))
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

#Preview {
    DiaryView()
}

