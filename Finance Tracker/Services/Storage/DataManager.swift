//
//  DataManager.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 6.11.2024.
//

import SwiftUI
import SwiftData

// MARK: - DataManager Class
class DataManager {
    static let shared = DataManager()

    // MARK: - Save Method
    func save(context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Error occurred while saving context: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete Method
    func delete<T: PersistentModel>(_ object: T, context: ModelContext) {
        context.delete(object)
        save(context: context)  
    }
}
