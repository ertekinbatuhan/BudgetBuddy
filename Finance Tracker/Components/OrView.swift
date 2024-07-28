//
//  OrView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.07.2024.
//

import SwiftUI

struct OrView : View {
    
    var title : String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.gray.opacity(0.3))
            Text(title)
                .padding(.horizontal, 10)
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.gray.opacity(0.3))
        }
        .padding(.horizontal, 30)
    }
}

