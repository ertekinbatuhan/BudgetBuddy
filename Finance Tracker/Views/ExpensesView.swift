import SwiftUI
import SwiftData

struct ExpensesView: View {
    
    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy) private var allExpenses: [Expense]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    @Binding var currentTab: String
    @ObservedObject private var viewModel = ExpensesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                    .onChange(of: viewModel.searchText) { newValue in
                        if !newValue.isEmpty {
                            viewModel.filterExpenses(newValue)
                        } else {
                            viewModel.groupedExpenses = viewModel.originalGroupedExpenses
                        }
                    }
                
                ZStack {
                    
                    CircularProgressView(categories: allCategories, categoryColors: viewModel.categoryColors)
                        .frame(width: 200, height: 200)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Total")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text(viewModel.totalAmountString)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.top)
                
                List {
                    ForEach(viewModel.groupedExpenses) { group in
                        Section(header: Text(group.groupTitle).font(.headline).foregroundColor(.primary)) {
                            ForEach(group.expenses) { expense in
                                ExpensesCardView(expense: expense)
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
                .navigationTitle("Expenses")
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
                    AddExpenseView().interactiveDismissDisabled()
                }
                .overlay {
                    if allExpenses.isEmpty || viewModel.groupedExpenses.isEmpty || currentTab == "Kategoriler" {
                        ContentUnavailableView {
                            Label("No Expenses", systemImage: "tray.fill")
                        }
                    }
                }
            }
        }
    }
}

