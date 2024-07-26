//
//  Double+Extension.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import Foundation

extension Double {
    func toCurrency() -> String {
        return NumberFormatter.dollarFormatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }

    func toPercentage() -> String {
        return String(format: "%.2f%%", self)
    }
}
