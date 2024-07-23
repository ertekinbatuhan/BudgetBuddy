import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy) private var allExpenses: [Expense]
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var originalGroupedExpenses: [GroupedExpenses] = []
    @State private var addExpense: Bool = false
    @Environment(\.modelContext) private var context
    @Binding var currentTab: String
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedExpenses) { group in
                    Section(header: Text(group.groupTitle)) {
                        ForEach(group.expenses) { expense in
                            ExpensesCardView(expense: expense)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        deleteExpense(expense, from: group)
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
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search"))
            .onAppear {
                createGroupedExpenses(allExpenses)
            }
            .onChange(of: allExpenses) { newValue in
                createGroupedExpenses(newValue)
            }
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty {
                    filterExpenses(newValue)
                } else {
                    groupedExpenses = originalGroupedExpenses
                }
            }
            .sheet(isPresented: $addExpense) {
                AddExpenseView().interactiveDismissDisabled()
            }
            .overlay {
                if allExpenses.isEmpty || groupedExpenses.isEmpty || currentTab == "Categories" {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "tray.fill")
                    }
                }
            }
        }
    }

    func filterExpenses(_ text: String) {
        Task.detached(priority: .high) {
            let query = text.lowercased()
            let filteredGroups = originalGroupedExpenses.compactMap { group -> GroupedExpenses? in
                let filteredExpenses = group.expenses.filter { $0.title.lowercased().contains(query) }
                return filteredExpenses.isEmpty ? nil : GroupedExpenses(date: group.date, expenses: filteredExpenses)
            }

            await MainActor.run {
                groupedExpenses = filteredGroups
            }
        }
    }

    private func deleteExpense(_ expense: Expense, from group: GroupedExpenses) {
        context.delete(expense)
        withAnimation {
            if let groupIndex = groupedExpenses.firstIndex(where: { $0.id == group.id }) {
                if let expenseIndex = groupedExpenses[groupIndex].expenses.firstIndex(where: { $0.id == expense.id }) {
                    groupedExpenses[groupIndex].expenses.remove(at: expenseIndex)
                }
               
                if groupedExpenses[groupIndex].expenses.isEmpty {
                    groupedExpenses.remove(at: groupIndex)
                }
            }
        }
    }

    private func createGroupedExpenses(_ expenses: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
                return dateComponents
            }

            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }

            await MainActor.run {
                groupedExpenses = sortedDict.compactMap { dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return GroupedExpenses(date: date, expenses: dict.value)
                }
                originalGroupedExpenses = groupedExpenses
            }
        }
    }
}

#Preview {
    
    TabBar()
}
