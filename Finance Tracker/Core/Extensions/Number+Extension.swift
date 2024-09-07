//
//  NumberFormatter.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import Foundation

extension NumberFormatter {
    
    // MARK: - Currency Formatting
    /// A `NumberFormatter` instance configured to format numbers as currency.
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        switch Locale.current.identifier {
        case "en_US":
            formatter.currencySymbol = "$"
        case "tr_TR":
            formatter.currencySymbol = "₺"
        default:
            formatter.currencySymbol = Locale.current.currencySymbol ?? ""
        }
        
        return formatter
    }
    
    // MARK: - Decimal Formatting
    /// A `NumberFormatter` instance configured to format numbers as decimal values.
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
