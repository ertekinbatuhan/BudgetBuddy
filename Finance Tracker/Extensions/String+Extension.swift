//
//  String+Extension.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftData
import SwiftUI



extension Finance {
    @Transient
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //formatter.locale = Locale.current
        formatter.currencySymbol = Locale.current.identifier == "tr_TR" ? "₺" : "$"

        return formatter.string(for: amount) ?? ""
    }
}
