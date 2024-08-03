//
//  ExpensesView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData

struct FinanceView: View {

    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy) private var allExpenses: [Expense]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) var colorScheme
    @Binding var currentTab: TabItem
    @State private var selectedType: FinanceType = .expense
    @ObservedObject private var viewModel = FinanceViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
               
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.resetFilters()
                    }
                
                ZStack {
                    CircularProgressView(categories: selectedType == .expense ? viewModel.expenseCategories : viewModel.incomeCategories,
                                         categoryColors: viewModel.categoryColors)
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                       
                    VStack {
                        Text("Total")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text(selectedType == .expense ? viewModel.totalExpenseAmountString : viewModel.totalIncomingAmountString)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.bottom)
                
                // Segmented Picker
                Picker("Select Type", selection: $selectedType) {
                    Text("Expenses").tag(FinanceType.expense)
                    Text("Income").tag(FinanceType.income)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom)
                .onChange(of: selectedType) { _ in
                    viewModel.selectedType = selectedType
                    viewModel.resetFilters()
                }
                
                List {
                    ForEach(viewModel.groupedExpenses) { group in
                        Section(header: Text(group.groupTitle).font(.headline).foregroundColor(.primary)) {
                            ForEach(group.expenses) { expense in
                                FinanceCardView(finance: expense)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button {
                                            viewModel.deleteExpense(expense, from: group, context: context)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Welcome")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.addExpense.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                }
                .onAppear {
                    viewModel.allExpenses = allExpenses
                    viewModel.allCategories = allCategories
                    viewModel.createGroupedExpenses(allExpenses)
                }
                .onChange(of: allExpenses) { newValue in
                    viewModel.allExpenses = newValue
                    viewModel.createGroupedExpenses(newValue)
                }
                .onChange(of: allCategories) { newValue in
                    viewModel.allCategories = newValue
                }
                .sheet(isPresented: $viewModel.addExpense) {
                    AddFinanceView().interactiveDismissDisabled()
                }
                .overlay {
                    if allExpenses.isEmpty || viewModel.groupedExpenses.isEmpty || currentTab == .categories {
                        VStack {
                            Spacer()
                            ContentUnavailableView {
                                VStack {
                                    if selectedType == .expense {
                                        Label("No Expenses", systemImage: "tray.fill")
                                    } else {
                                        Label("No Income", systemImage: "arrow.up.circle.fill")
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
