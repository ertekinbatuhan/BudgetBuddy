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
                                        Label("GENERAL_NO_FINANCE", systemImage: "tray.fill")
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
                                    .buttonStyle(PlainButtonStyle()) 
                                }
                            }
                        )
                    }
                }
            }
            .navigationTitle("GENERAL_CATEGORIES")
            .overlay {
                if viewModel.allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("GENERAL_NO_CATEGORIES", systemImage: "tray.fill")
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
                        Section("GENERAL_CATEGORY_NAME") {
                            TextField("CATEGORY_GENERAL", text: $viewModel.categoryName)
                        }
                    }
                    .navigationTitle("SECTION_CATEGORY")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("GENERAL_CANCEL_BUTTON") {
                                viewModel.addCategory = false
                            }
                            .tint(.red)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("GENERAL_ADD_BUTTON") {
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
        .alert("ALERT_DELETE_CATEGORY", isPresented: $viewModel.deleteRequest) {
            Button(role: .destructive) {
                viewModel.deleteCategory(context: context)
                if calculateViewModel.calculateCount % 3 == 0 {
                    adCoordinator.presentAd()
                }
                calculateViewModel.calculateCount += 1
            } label: {
                Text("GENERAL_DELETE_BUTTON")
            }
            Button(role: .cancel) {
                viewModel.requestedCategory = nil
            } label: {
                Text("GENERAL_CANCEL_BUTTON")
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
