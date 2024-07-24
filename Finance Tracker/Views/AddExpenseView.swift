import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = AddExpenseViewModel()
    @Query(animation: .snappy) private var allCategories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Write something", text: $viewModel.title)
                }
                Section("Description") {
                    TextField("Write something", text: $viewModel.subTitle)
                }
                Section("Amount Spent") {
                    HStack {
                        Text("$").fontWeight(.semibold)
                        TextField("Write something", value: $viewModel.amount, formatter: NumberFormatter.decimalFormatter)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Date") {
                    DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                
                if !allCategories.isEmpty {
                    HStack {
                        Text("Category")
                        Spacer()
                        Menu {
                            ForEach(allCategories) { category in
                                Button(category.categoryName) {
                                    viewModel.category = category
                                }
                            }
                            Button("None") {
                                viewModel.category = nil
                            }
                        } label: {
                            if let categoryName = viewModel.category?.categoryName {
                                Text(categoryName)
                            } else {
                                Text("None")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: {
                        viewModel.addExpense(context: context)
                        dismiss()
                    })
                    .disabled(viewModel.isAddButtonDisabled)
                }
            }
        }
    }
}

