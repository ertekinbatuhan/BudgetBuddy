//
//  Reminder.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 13.08.2024.
//

import SwiftUI
import SwiftData

@Model
class Reminder {
    var id: UUID
    var title: String
    var date: Date
    var notes: String

    init(title: String, date: Date, notes: String) {
        self.title = title
        self.date = date
        self.notes = notes
        self.id = UUID()
    }
}
