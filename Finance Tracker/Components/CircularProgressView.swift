import SwiftUI

// MARK: - CircularProgressView
// A view displaying a circular progress chart representing different categories.
struct CircularProgressView: View {
    let categories: [Category]
    let categoryColors: [Category: Color]
    
    // MARK: - Computed Properties
    // Total amount of all finances across all categories.
    private var totalAmount: Double {
        categories.flatMap { $0.finances ?? [] }
            .reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            ForEach(categories, id: \.categoryName) { category in
                let amount = calculateTotalAmount(for: category)
                let percentage = totalAmount == 0 ? 0 : amount / totalAmount
                let startAngle = getStartAngle(for: category)
                let endAngle = startAngle + (percentage * 360)
                
                let gap: Double = 1 // Gap between segments
                
                Circle()
                    .trim(from: (startAngle / 360) + (gap / 360), to: (endAngle / 360) - (gap / 360))
                    .stroke(
                        categoryColors[category]?.opacity(0.8) ?? .gray,
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .butt
                        )
                    )
                    .rotationEffect(.degrees(-90))
            }
        }
        .frame(width: 200, height: 200)
    }
    
    // MARK: - Methods
    // Calculates the total amount for a given category.
    private func calculateTotalAmount(for category: Category) -> Double {
        category.finances?.reduce(0) { $0 + $1.amount } ?? 0
    }
    
    // Determines the starting angle for a given category.
    private func getStartAngle(for category: Category) -> Double {
        let usedCategories = categories.prefix(while: { $0 != category })
        let usedAmount = usedCategories.flatMap { $0.finances ?? [] }
            .reduce(0) { $0 + $1.amount }
        return (usedAmount / totalAmount) * 360
    }
}
