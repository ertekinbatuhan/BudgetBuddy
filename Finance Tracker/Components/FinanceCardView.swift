//
//  ExpensesCardView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI

struct FinanceCardView: View {
    
    @Bindable var finance : Finance
    
    var displayTag : Bool = true
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(finance.title)
                
                Text(finance.subTitle).font(.caption).foregroundStyle(.gray)
                
                if let categoryName = finance.category?.categoryName ,displayTag {
                    Text(categoryName).font(.caption2).foregroundStyle(.white).padding(.horizontal,10).padding(.vertical,4)
                        .background(.blue.gradient, in: .capsule)
                }
                
                //red.graident unutma
                    
            }
            .lineLimit(3)
            
            Spacer(minLength: 5)
           
            Text(finance.currencyString).font(.title3.bold())
            
        }
    }
}

