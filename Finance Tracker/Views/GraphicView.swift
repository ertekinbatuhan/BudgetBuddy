//
//  GraphicView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 15.08.2024.
//
/*
import SwiftUI
import Charts

struct GraphicView: View {
    @ObservedObject var viewModel = FinanceViewModel()

    var body: some View {
        VStack {
            Text("Gelir ve Gider Grafiği")
                .font(.title)
                .padding()
            
            Chart {
                BarMark(
                    x: .value("Finance Type", "Gelir"),
                    y: .value("Amount", viewModel.totalAmount(for: .income))
                    
                )
                .foregroundStyle(Color.green)
                
                BarMark(
                    x: .value("Finance Type", "Gider"),
                    y: .value("Amount", viewModel.totalAmount(for: .expense))
                )
                .foregroundStyle(Color.red)
            }.onAppear{
               
            }
            .frame(height: 300)
            .padding()
        }
    }
}

*/
