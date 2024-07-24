
import Foundation
import SwiftUI
import SwiftData

class AddExpenseViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var date: Date = .init()
    @Published var amount: CGFloat = 0
    @Published var category: Category?
    
    var isAddButtonDisabled: Bool {
        return title.isEmpty || subTitle.isEmpty || amount == .zero
    }
    
    func addExpense(context: ModelContext) {
        let expense = Expense(title: title, subTitle: subTitle, amount: amount, date: date, category: category)
        context.insert(expense)
    }
}

