import Foundation
import SwiftUI
import SwiftData

protocol AddFinanceViewModelProtocol {
    func addFinance(context: ModelContext)
}

class AddFinanceViewModel: AddFinanceViewModelProtocol , ObservableObject {
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var date: Date = .init()
    @Published var amount: Double = 0
    @Published var category: Category?
    @Published var selectedType: FinanceType = .expense
    
    var isAddButtonDisabled: Bool {
        return title.isEmpty || subTitle.isEmpty || amount == .zero
    }
    
    func addFinance(context: ModelContext) {
        let finance = Finance(title: title, subTitle: subTitle, amount: Double(amount), date: date, type: selectedType, category: category)
        context.insert(finance)
    }
}
