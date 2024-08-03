//
//  AddExpenseView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData

struct AddFinanceView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @ObservedObject private var viewModel = AddFinanceViewModel()
    @Query(animation: .snappy) private var allCategories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Enter title here", text: $viewModel.title)
                }
                Section("Description") {
                    TextField("Enter description here", text: $viewModel.subTitle)
                }
                
                Section("Amount") {
                    HStack {
                        Text("₺").fontWeight(.semibold)
                        TextField("Write amount", value: $viewModel.amount, formatter: NumberFormatter.decimalFormatter)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("Type Selection") {
                    HStack {
                        ForEach(FinanceType.allCases) { type in
                            Button(action: {
                                viewModel.selectedType = type
                            }) {
                                HStack {
                                    Image(systemName: viewModel.selectedType == type ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(viewModel.selectedType == type ? .blue : .gray)
                                    Text(type.rawValue)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle()) 
                        }
                    }
                }
                
                Section("Date") {
                    DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                
                if !allCategories.isEmpty {
                    Section("Category") {
                        HStack {
                            Text("Category")
                            Spacer()
                            Menu {
                                ForEach(allCategories) { category in
                                    Button(category.categoryName) {
                                        viewModel.category = category
                                    }
                                }
                                Button("None") {
                                    viewModel.category = nil
                                }
                            } label: {
                                if let categoryName = viewModel.category?.categoryName {
                                    Text(categoryName)
                                } else {
                                    Text("None")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: {
                        viewModel.addFinance(context: context)
                        dismiss()
                    })
                    .disabled(viewModel.isAddButtonDisabled)
                }
            }
        }
    }
}

