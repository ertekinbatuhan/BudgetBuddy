//
//  CategoriesView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel = CategoriesViewModel()
    @Query(animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    @ObservedObject private var authViewModel = AuthViewModel()
    @State private var showSignInView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.allCategories) { category in
                    DisclosureGroup {
                        if let expenses = category.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                FinanceCardView(finance: expense, displayTag: false)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                    } label: {
                        Text(category.categoryName)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            viewModel.requestDeleteCategory(category)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("Categories")
            .overlay {
                if viewModel.allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("No categories", systemImage: "tray.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addCategory.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        authViewModel.signOut()
                        showSignInView = true
                    } label: {
                        Text("Log Out")
                    }
                }
            }
            .sheet(isPresented: $viewModel.addCategory) {
                viewModel.categoryName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("Title") {
                            TextField("General", text: $viewModel.categoryName)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                viewModel.addCategory = false
                            }
                            .tint(.red)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add") {
                                viewModel.addNewCategory(context: context)
                            }
                            .disabled(viewModel.categoryName.isEmpty)
                        }
                        
                        
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }
            .fullScreenCover(isPresented: $showSignInView) {
                SignInView().navigationBarBackButtonHidden(true)
            }
        }
        .alert("If you delete a category, all the associated expenses will be deleted too.", isPresented: $viewModel.deleteRequest) {
            Button(role: .destructive) {
                viewModel.deleteCategory(context: context)
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                viewModel.requestedCategory = nil
            } label: {
                Text("Cancel")
            }
        }
        .onAppear {
            viewModel.fetchCategories(categories: allCategories)
        }
        .onChange(of: allCategories) { newCategories in
            viewModel.fetchCategories(categories: newCategories)
        }
    }
}

#Preview {
    CategoriesView()
}
