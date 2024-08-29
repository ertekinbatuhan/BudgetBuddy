//
//  DateFormatter.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import Foundation

extension DateFormatter {
    
    // MARK: - Day, Month, Year Formatter
    /// A `DateFormatter` instance configured to format dates as "dd MMM yyyy".
    static let dayMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.dateStyle = .full
        return formatter
    }()
    
    // MARK: - General Date Formatter
    /// A `DateFormatter` instance configured to format dates with full date and time style.
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeZone = TimeZone.current
        return formatter
    }
}
