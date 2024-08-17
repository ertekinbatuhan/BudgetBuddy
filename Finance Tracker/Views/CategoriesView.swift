//
//  CategoriesView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

struct CategoriesView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel = CategoriesViewModel()
    @Query(animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    private let adCoordinator = AdCoordinator.shared
    @State private var calculateViewModel = CalculateViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("")) {
                    ForEach(viewModel.allCategories) { category in
                        DisclosureGroup(
                            content: {
                                if let expenses = category.finances, !expenses.isEmpty {
                                    ForEach(expenses) { expense in
                                        FinanceCardView(finance: expense, displayTag: false)
                                    }
                                } else {
                                    ContentUnavailableView {
                                        Label("CONVERSATION_NOFINANCE", systemImage: "tray.fill")
                                    }
                                }
                            },
                            label: {
                                HStack {
                                    Text(category.categoryName)
                                        .font(.headline)
                                    Spacer()
                                    Button(action: {
                                        viewModel.requestDeleteCategory(category)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Bu butonu daha az etkileşimli hale getirir.
                                }
                            }
                        )
                    }
                }
            }
            .navigationTitle("CONVERSATION_CATEGORIES")
            .overlay {
                if viewModel.allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("CONVERSATION_NOCATEGORIES", systemImage: "tray.fill")
                    }
                }
            }
           BannerView()
            .frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addCategory.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
            }
            .sheet(isPresented: $viewModel.addCategory) {
                viewModel.categoryName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("CATEGORY_TITLE") {
                            TextField("CATEGORY_GENERAL", text: $viewModel.categoryName)
                        }
                    }
                    .navigationTitle("CONVERSION_CATEGORYNAME")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("CANCEL_BUTTON") {
                                viewModel.addCategory = false
                            }
                            .tint(.red)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("ADD_BUTTON") {
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
        }
        .alert("ALERT", isPresented: $viewModel.deleteRequest) {
            Button(role: .destructive) {
                viewModel.deleteCategory(context: context)
                if calculateViewModel.calculateCount % 3 == 0 {
                    adCoordinator.presentAd()
                }
                calculateViewModel.calculateCount += 1
            } label: {
                Text("DELETE_BUTTON")
            }
            Button(role: .cancel) {
                viewModel.requestedCategory = nil
            } label: {
                Text("CANCEL_BUTTON")
            }
        }
        .onAppear {
            viewModel.fetchCategories(categories: allCategories)
           
            
        }
        .onChange(of: allCategories) {
            viewModel.fetchCategories(categories: allCategories)
        }
    }
}

#Preview {
    CategoriesView()
}
