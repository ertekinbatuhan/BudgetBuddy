import SwiftUI

// MARK: - FinanceCardView
// A view displaying detailed information about a financial record.
struct FinanceCardView: View {
    
    @Bindable var finance: Finance
    var displayTag: Bool = true
    
    // MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(finance.title)
                
                Text(finance.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                if let categoryName = finance.category?.categoryName, displayTag {
                    Text(categoryName)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.pink]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        )
                }
            }
            .lineLimit(3)
            
            Spacer(minLength: 5)
            
            Text(finance.currencyString)
                .font(.title3.bold())
        }
    }
}
