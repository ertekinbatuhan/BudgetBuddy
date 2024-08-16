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
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("CONVERSATION_TOTAL")
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
                    Text("CONVERSATION_EXPENSES").tag(FinanceType.expense)
                    Text("CONVERSATION_INCOME").tag(FinanceType.income)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom)
             //   .onChange(of: selectedType) { //bura komple iptal
               //     viewModel.resetFilters()
                //    viewModel.filterFinances(viewModel.searchText) //bunu eklemiş sadece
              //  }
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
                .navigationTitle("CONVERSATION_WELCOME_TITLE")
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
                .onChange(of: viewModel.searchText) { newValue in
                    if newValue.isEmpty {
                        viewModel.resetFilters()
                        viewModel.createGroupedFinances(allFinances)
                    } else {
                        viewModel.filterFinances(newValue)
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
                                        Label("CONVERSATION_NOEXPENSES", systemImage: "tray.fill")
                                    } else {
                                        Label("CONVERSATION_NOINCOME", systemImage: "arrow.up.circle.fill")
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
