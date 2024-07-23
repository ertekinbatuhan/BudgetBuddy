import SwiftUI

struct CircularProgressView: View {
    let categories: [Category]
    let categoryColors: [Category: Color]

    private var totalAmount: Double {
        categories.flatMap { $0.expenses ?? [] }.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        ZStack {
            ForEach(categories, id: \.categoryName) { category in
                let amount = calculateTotalAmount(for: category)
                let percentage = totalAmount == 0 ? 0 : amount / totalAmount
                let startAngle = getStartAngle(for: category)
                let endAngle = startAngle + (percentage * 360)
                
                Circle()
                    .trim(from: startAngle / 360, to: endAngle / 360)
                    .stroke(
                        categoryColors[category]?.opacity(0.8) ?? .gray,
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
            }
        }
        .frame(width: 200, height: 200) 
    }
    
    private func calculateTotalAmount(for category: Category) -> Double {
        category.expenses?.reduce(0) { $0 + $1.amount } ?? 0
    }
    
    private func getStartAngle(for category: Category) -> Double {
        let usedCategories = categories.prefix(while: { $0 != category })
        let usedAmount = usedCategories.flatMap { $0.expenses ?? [] }.reduce(0) { $0 + $1.amount }
        return (usedAmount / totalAmount) * 360
    }
}


