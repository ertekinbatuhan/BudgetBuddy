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
    private let adCoordinator = AdCoordinator.shared
    @State private var calculateViewModel = CalculateViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    CircularProgressView(categories: selectedType == .expense ? viewModel.expenseCategories : viewModel.incomeCategories,
                                         categoryColors: viewModel.categoryColors)
                    .frame(width: 210, height: 210)
                    .shadow(radius: 10)
                    
                    VStack {
                        Text("GENERAL_TOTAL")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text(selectedType == .expense ? viewModel.totalExpenseAmountString : viewModel.totalIncomingAmountString)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.horizontal, 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.bottom)
                .searchable(text: $viewModel.searchText)
                .padding(.top, 15)
                
                Picker("Select Type", selection: $selectedType) {
                    Text("FINANCE_TYPE_EXPENSE").tag(FinanceType.expense)
                    Text("FINANCE_TYPE_INCOME").tag(FinanceType.income)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom)
                
                .onChange(of: selectedType) {
                    viewModel.selectedType = selectedType
                    viewModel.resetFilters()
                    viewModel.createGroupedFinances(allFinances)
                }
                
                List {
                    ForEach(viewModel.groupedFinances) { group in
                        Section(header: Text(group.groupTitle).font(.headline).foregroundColor(.primary)) {
                            ForEach(group.finances) { finance in
                                FinanceCardView(finance: finance)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button {
                                            viewModel.deleteFinance(finance, from: group, context: context)
                                            if calculateViewModel.calculateCount % 3 == 0 {
                                                adCoordinator.presentAd()
                                            }
                                            calculateViewModel.calculateCount += 1
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
                
                .navigationTitle("GENERAL_WELCOME_TITLE")
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
                .onChange(of: allFinances) {
                    viewModel.allFinances = allFinances
                    viewModel.createGroupedFinances(allFinances)
                }
                .onChange(of: allCategories) { 
                    viewModel.allCategories = allCategories
                }
                .onChange(of: viewModel.searchText) {
                    if viewModel.searchText.isEmpty {
                        viewModel.resetFilters()
                        viewModel.createGroupedFinances(allFinances)
                    } else {
                        viewModel.filterFinances(viewModel.searchText)
                    }
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
                                        Label("GENERAL_NO_EXPENSES", systemImage: "tray.fill")
                                    } else {
                                        Label("GENERAL_NO_FINANCE", systemImage: "arrow.up.circle.fill")
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
