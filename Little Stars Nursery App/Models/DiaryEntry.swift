//
//  DiaryEntry.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-02.
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
        description: "Nethan arrived with a big smile and was excited to see his friends in the sensory corner.",
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
        description: "Nethan explored finger painting today. He was very focused on mixing blue and yellow to make green.",
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
        description: "Nethan loved the sandbox today and made a castle with his best friend Eshini. Great social interaction!",
        imageName: "child_drawing"
    ),
    DiaryEntry(
        category: .pickup,
        time: "05:00 PM",
        title: "PICK-UP MOOD",
        description: "Nethan was in great spirits at pick-up, chatting about his painting and showing mum his green creation.",
        imageName: nil
    )
]
