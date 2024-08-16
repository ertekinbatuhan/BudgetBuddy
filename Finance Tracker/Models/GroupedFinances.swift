//
//  GroupedFinances.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import Foundation

struct GroupedFinances: Identifiable {
    var id = UUID()
    var date: Date
    var finances: [Finance]
    
    var groupTitle: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return NSLocalizedString("Today", comment: "")
        } else if calendar.isDateInYesterday(date) {
            return NSLocalizedString("Yesterday", comment: "")
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
}
