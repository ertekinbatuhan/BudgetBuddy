//
//  ExpensesView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData

struct FinanceView: View {

    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) var colorScheme
    @Binding var currentTab: TabItem
    @State private var selectedType: FinanceType = .expense
    @StateObject private var viewModel = FinanceViewModel()
    
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
                    ForEach(viewModel.groupedFinances) { group in
                        Section(header: Text(group.groupTitle).font(.headline).foregroundColor(.primary)) {
                            ForEach(group.finances) { finance in
                                FinanceCardView(finance: finance)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button {
                                            viewModel.deleteFinance(finance, from: group, context: context)
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
                            viewModel.addFinance.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                }
                .onAppear {
                    viewModel.allFinances = allFinances
                    viewModel.allCategories = allCategories
                    viewModel.createGroupedFinances(allFinances)
                }
                .onChange(of: allFinances) { newValue in
                    viewModel.allFinances = newValue
                    viewModel.createGroupedFinances(newValue)
                }
                .onChange(of: allCategories) { newValue in
                    viewModel.allCategories = newValue
                }
                .sheet(isPresented: $viewModel.addFinance) {
                    AddFinanceView().interactiveDismissDisabled()
                }
                .overlay {
                    if allFinances.isEmpty || viewModel.groupedFinances.isEmpty || currentTab == .categories {
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
