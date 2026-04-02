//
//  ChatMessage.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-02.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let time: String
    let isFromMe: Bool
    let imageName: String?

    init(text: String, time: String, isFromMe: Bool, imageName: String? = nil) {
        self.text = text
        self.time = time
        self.isFromMe = isFromMe
        self.imageName = imageName
    }
}

let sampleMessages: [ChatMessage] = [
    ChatMessage(text: "Good morning! Nethan arrived happy and full of energy today 🌟", time: "08:32 AM", isFromMe: false),
    ChatMessage(text: "That's lovely to hear! He was excited about painting this morning.", time: "08:35 AM", isFromMe: true),
    ChatMessage(text: "Hi there! Just wanted to let you know that Nethan had a great morning. He finished all his fruit snack today!", time: "09:42 AM", isFromMe: false),
    ChatMessage(text: "That's wonderful to hear, thank you Ayesha! Did he manage to take his nap at the usual time?", time: "09:45 AM", isFromMe: true),
    ChatMessage(text: "", time: "10:15 AM", isFromMe: false, imageName: "child_build"),
    ChatMessage(text: "He's currently busy with the blocks! We'll start the nap transition in about 15 minutes. 🧩", time: "10:15 AM", isFromMe: false),
    ChatMessage(text: "Perfect, thank you so much for the update!", time: "10:18 AM", isFromMe: true),
    ChatMessage(text: "Nethan just woke up from his nap — slept for a full hour 😴 He's in great mood!", time: "12:55 PM", isFromMe: false),
    ChatMessage(text: "Amazing! Did he eat his lunch well?", time: "01:02 PM", isFromMe: true),
    ChatMessage(text: "He ate almost everything — pasta, broccoli, and loved the fruit dessert 🍓", time: "01:10 PM", isFromMe: false),
    ChatMessage(text: "He's been asking about you! We told him mummy is coming soon 💛", time: "02:30 PM", isFromMe: false),
    ChatMessage(text: "Aww that melts my heart 🥹 I'll be there by 3!", time: "02:33 PM", isFromMe: true),
    ChatMessage(text: "Nethan had a wonderful day today! See you soon 👋", time: "02:45 PM", isFromMe: false),
]
