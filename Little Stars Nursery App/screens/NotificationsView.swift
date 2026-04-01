//
//  NotificationsView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-01.
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
        message: "Leo had a small fall in the playground. He is fine and has been comforted by staff.",
        time: "10:32 AM",
        isUnread: true
    ),
    AppNotification(
        type: .pickup,
        title: "Pick-Up Confirmed",
        message: "David Mitchell has been authorised and collected Leo at 3:05 PM today.",
        time: "3:06 PM",
        isUnread: true
    ),
    AppNotification(
        type: .summary,
        title: "Daily Summary Ready",
        message: "Leo's full activity diary for Thursday is now available to view.",
        time: "5:00 PM",
        isUnread: false
    ),
    AppNotification(
        type: .message,
        title: "Message from Sarah J.",
        message: "Leo had a wonderful day today! He loved the finger painting session.",
        time: "2:45 PM",
        isUnread: false
    ),
    AppNotification(
        type: .summary,
        title: "Weekly Report",
        message: "Your weekly nursery summary for Leo is ready. Tap to review.",
        time: "Yesterday",
        isUnread: false
    ),
    AppNotification(
        type: .pickup,
        title: "Arrival Confirmed",
        message: "Leo arrived safely at nursery and has been signed in by Sarah J.",
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
        message: "Please note that a nut product was brought in today. Leo was kept safe per his care plan.",
        time: "Mon",
        isUnread: false
    ),
    AppNotification(
        type: .summary,
        title: "Monthly Progress Report",
        message: "Leo's monthly development summary is now available. Great progress this month!",
        time: "Mon",
        isUnread: false
    ),
    AppNotification(
        type: .message,
        title: "Message from Ms. Olivia",
        message: "Leo made a new friend today — he and Jamie built a sandcastle together!",
        time: "Sun",
        isUnread: false
    ),
]

struct NotificationsView: View {
    @Binding var isPresented: Bool

    private let bgColor        = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        ZStack(alignment: .top) {
            bgColor.ignoresSafeArea()

            VStack(spacing: 0) {

                HStack(spacing: 14) {
                    Button(action: {
                        isPresented = false
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.91, green: 0.92, blue: 0.93))
                                .frame(width: 38, height: 38)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(secondaryColor)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    Text("Notifications")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))

                    Spacer()

                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(Color(red: 0.91, green: 0.92, blue: 0.93))
                            .frame(width: 38, height: 38)
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundColor(secondaryColor)
                            .frame(width: 38, height: 38)

                        Circle()
                            .fill(Color(red: 0.92, green: 0.28, blue: 0.25))
                            .frame(width: 9, height: 9)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .offset(x: 1, y: 1)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
                .background(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(sampleNotifications.enumerated()), id: \.element.id) { index, notification in
                            NotificationListRow(notification: notification)
                            if index < sampleNotifications.count - 1 {
                                Divider()
                                    .padding(.leading, 78)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 100)
                }
            }
        }
        .transition(.move(edge: .trailing))
    }
}

struct NotificationListRow: View {
    let notification: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 14) {

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(notification.type.bgColor)
                    .frame(width: 46, height: 46)
                Image(systemName: notification.type.icon)
                    .font(.system(size: 20))
                    .foregroundColor(notification.type.color)
            }
            .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                        .lineLimit(1)
                    Spacer()
                    Text(notification.time)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.63, blue: 0.66))
                }

                Text(notification.message)
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.42, green: 0.45, blue: 0.48))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if notification.isUnread {
                Circle()
                    .fill(Color(red: 0.18, green: 0.77, blue: 0.71))
                    .frame(width: 9, height: 9)
                    .padding(.top, 6)
            } else {
                Spacer().frame(width: 9)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            notification.isUnread
            ? Color(red: 0.96, green: 0.99, blue: 0.99)
            : Color.white
        )
    }
}

#Preview {
    NotificationsView(isPresented: .constant(true))
}
