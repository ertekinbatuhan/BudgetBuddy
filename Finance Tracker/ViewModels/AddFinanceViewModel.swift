import Foundation
import SwiftUI
import SwiftData

protocol AddFinanceViewModelProtocol {
    var title: String { get set }
    var subTitle: String { get set }
    var date: Date { get set }
    var amount: Double { get set }
    var category: Category? { get set }
    var selectedType: FinanceType { get set }
    
    var isAddButtonDisabled: Bool { get }
    
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
