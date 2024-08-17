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
                InfoCardView(title: "Toplam", amount: totalAmount(for: .income) + totalAmount(for: .expense), color: .blue)
                    .padding()
                
                HStack(spacing: 16) {
                    InfoCardView(title: "Gelirler", amount: totalAmount(for: .income), color: .green)
                        .frame(maxWidth: .infinity)
                    
                    InfoCardView(title: "Giderler", amount: totalAmount(for: .expense), color: .red)
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

struct InfoCardView: View {
    let title: String
    let amount: Double
    let color: Color
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .multilineTextAlignment(.center)
            Text(NumberFormatter.currencyFormatter.string(from: NSNumber(value: amount)) ?? "₺0.00")  
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(color.opacity(colorScheme == .dark ? 0.2 : 0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CategoryBarChartView: View {
    let categories: [Category]
    let finances: [Finance]
    
    var body: some View {
        Chart {
            ForEach(categories, id: \.self) { category in
              
                BarMark(
                    x: .value("Kategori", category.categoryName),
                    y: .value("Gelir", totalAmount(for: .income, in: category))
                )
                .foregroundStyle(.green)
                
               
                BarMark(
                    x: .value("Kategori", category.categoryName),
                    y: .value("Gider", totalAmount(for: .expense, in: category))
                )
                .foregroundStyle(.red)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: categories.map { $0.categoryName })
        }
        .padding()
    }
    
    private func totalAmount(for type: FinanceType, in category: Category) -> Double {
        return finances
            .filter { $0.financeType == type && $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    SummaryView()
}
