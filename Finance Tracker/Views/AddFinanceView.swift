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
                Section("SECTION_TITLE") {
                    TextField("FINANCE_ENTER_TITLE", text: $viewModel.title)
                }
                Section("SECTION_DESCRIPTION") {
                    TextField("FINANCE_ENTER_DESCRIPTION", text: $viewModel.subTitle)
                }
                
                Section("SECTION_AMOUNT") {
                    HStack {
                        Text("GENERAL_AMOUNT_ICON").fontWeight(.semibold)
                        TextField("FINANCE_ENTER_AMOUNT", value: $viewModel.amount, formatter: NumberFormatter.decimalFormatter)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("SECTION_TYPE_SELECTION") {
                    HStack {
                        ForEach(FinanceType.allCases) { type in
                            Button(action: {
                                viewModel.selectedType = type
                            }) {
                                HStack {
                                    Image(systemName: viewModel.selectedType == type ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(viewModel.selectedType == type ? .blue : .gray)
                                    Text(type.localizedTitle)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
                Section("SECTION_DATE") {
                    DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                
                if !allCategories.isEmpty {
                    Section("GENERAL_CATEGORIES") {
                        HStack {
                            Text("GENERAL_CATEGORIES")
                            Spacer()
                            Menu {
                                ForEach(allCategories) { category in
                                    Button(category.categoryName) {
                                        viewModel.category = category
                                    }
                                }
                                Button("GENERAL_NONE_BUTTON") {
                                    viewModel.category = nil
                                }
                            } label: {
                                if let categoryName = viewModel.category?.categoryName {
                                    Text(categoryName)
                                } else {
                                    Text("GENERAL_NONE_TEXT")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("FINANCE_ADD")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("GENERAL_CANCEL_BUTTON") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("GENERAL_ADD_BUTTON") {
                        if viewModel.category != nil {
                            viewModel.addFinance(context: context)
                            dismiss()
                        }
                    }
                    .disabled(viewModel.category == nil || viewModel.isAddButtonDisabled)
                }
            }
        }
    }
}
