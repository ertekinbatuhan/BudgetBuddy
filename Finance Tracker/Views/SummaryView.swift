import Charts
import SwiftUI
import SwiftData

struct SummaryView: View {
    
    // MARK: - Data Queries
    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    
    // MARK: - Environment Variables
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    // MARK: - View Models
    @ObservedObject private var viewModel = FinanceViewModel()
    // MARK: - State Variables
    @State private var isShowingCalendar = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                InfoCardView(title: "GENERAL_TOTAL", amount: viewModel.totalAmount(for: .income) + viewModel.totalAmount(for: .expense), color: .blue)
                    .padding()
                
                HStack(spacing: 16) {
                    InfoCardView(title: "GENERAL_INCOME", amount: viewModel.totalAmount(for: .income), color: .green)
                        .frame(maxWidth: .infinity)
                    
                    InfoCardView(title: "GENERAL_EXPENSES", amount: viewModel.totalAmount(for: .expense), color: .red)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                
                CategoryBarChartView(categories: allCategories, finances: allFinances)
                    .frame(height: 300)
                
                Spacer()
            }
            .navigationTitle("FINANCE_STATUS")
            .background(colorScheme == .dark ? Color.black : Color.white)
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingCalendar.toggle()
                    }) {
                        Image(systemName: "calendar")
                        
                    }
                }
            }
            .sheet(isPresented: $isShowingCalendar) {
                CalendarView()
            }
        }
    }
}

#Preview {
    SummaryView()
}
