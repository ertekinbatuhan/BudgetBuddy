//
//  NumberFormatter.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import Foundation

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        // Set locale and currency symbol based on current locale
        formatter.locale = Locale.current
        
        // Update currency symbol based on the locale
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
    
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
