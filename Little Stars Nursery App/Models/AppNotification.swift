//
//  AppNotification.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-02.
//

import SwiftUI

struct AppNotification: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let time: String
    let isUnread: Bool
}

enum NotificationType {
    case incident
    case pickup
    case summary
    case message

    var icon: String {
        switch self {
        case .incident: return "exclamationmark.triangle.fill"
        case .pickup:   return "checkmark.circle.fill"
        case .summary:  return "doc.text.fill"
        case .message:  return "bubble.left.fill"
        }
    }

    var color: Color {
        switch self {
        case .incident: return Color(red: 0.92, green: 0.28, blue: 0.25)
        case .pickup:   return Color(red: 0.20, green: 0.72, blue: 0.40)
        case .summary:  return Color(red: 0.18, green: 0.77, blue: 0.71)
        case .message:  return Color(red: 0.11, green: 0.56, blue: 0.53)
        }
    }

    var bgColor: Color {
        switch self {
        case .incident: return Color(red: 0.99, green: 0.93, blue: 0.92)
        case .pickup:   return Color(red: 0.92, green: 0.98, blue: 0.94)
        case .summary:  return Color(red: 0.92, green: 0.98, blue: 0.98)
        case .message:  return Color(red: 0.90, green: 0.97, blue: 0.96)
        }
    }
}

let sampleNotifications: [AppNotification] = [
    AppNotification(
        type: .incident,
        title: "Minor Incident Report",
        message: "Nethan had a small fall in the playground. He is fine and has been comforted by staff.",
        time: "10:32 AM",
        isUnread: true
    ),
    AppNotification(
        type: .pickup,
        title: "Pick-Up Confirmed",
        message: "Nadan Perera has been authorised and collected Nethan at 3:05 PM today.",
        time: "3:06 PM",
        isUnread: true
    ),
    AppNotification(
        type: .summary,
        title: "Daily Summary Ready",
        message: "Nethan's full activity diary for Thursday is now available to view.",
        time: "5:00 PM",
        isUnread: false
    ),
    AppNotification(
        type: .message,
        title: "Message from Ayesha",
        message: "Nethan had a wonderful day today! He loved the finger painting session.",
        time: "2:45 PM",
        isUnread: false
    ),
    AppNotification(
        type: .summary,
        title: "Weekly Report",
        message: "Your weekly nursery summary for Nethan is ready. Tap to review.",
        time: "Yesterday",
        isUnread: false
    ),
    AppNotification(
        type: .pickup,
        title: "Arrival Confirmed",
        message: "Nethan arrived safely at nursery and has been signed in by Ayesha",
        time: "08:31 AM",
        isUnread: false
    ),
    AppNotification(
        type: .message,
        title: "Message from Nursery Admin",
        message: "Reminder: Parent evening is this Thursday at 5:30 PM. Please confirm attendance.",
        time: "Yesterday",
        isUnread: false
    ),
    AppNotification(
        type: .incident,
        title: "Allergy Alert",
        message: "Please note that a nut product was brought in today. Nethan was kept safe per his care plan.",
        time: "Mon",
        isUnread: false
    ),
    AppNotification(
        type: .summary,
        title: "Monthly Progress Report",
        message: "Nethan's monthly development summary is now available. Great progress this month!",
        time: "Mon",
        isUnread: false
    ),
    AppNotification(
        type: .message,
        title: "Message from Ms. Olivia",
        message: "Nethan made a new friend today — he and Jamie built a sandcastle together!",
        time: "Sun",
        isUnread: false
    ),
]
