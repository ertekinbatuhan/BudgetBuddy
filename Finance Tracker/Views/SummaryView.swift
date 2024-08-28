import Charts
import SwiftUI
import SwiftData

struct SummaryView: View {
    
    @Query(sort: [SortDescriptor(\Finance.date, order: .reverse)], animation: .snappy) private var allFinances: [Finance]
    @Query(sort: [SortDescriptor(\Category.categoryName)], animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                InfoCardView(title: "GENERAL_TOTAL", amount: totalAmount(for: .income) + totalAmount(for: .expense), color: .blue)
                    .padding()
                
                HStack(spacing: 16) {
                    InfoCardView(title: "GENERAL_INCOME", amount: totalAmount(for: .income), color: .green)
                        .frame(maxWidth: .infinity)
                    
                    InfoCardView(title: "GENERAL_EXPENSES", amount: totalAmount(for: .expense), color: .red)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                
                CategoryBarChartView(categories: allCategories, finances: allFinances)
                    .frame(height: 300)
                
                Spacer()
            }
            .navigationTitle("Finansal Durum")
            .background(colorScheme == .dark ? Color.black : Color.white)
            .padding()
        }
    }

    func totalAmount(for type: FinanceType) -> Double {
        return allFinances
            .filter { $0.financeType == type }
            .reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    SummaryView()
}
