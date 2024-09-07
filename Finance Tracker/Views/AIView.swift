//
//  AIView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import SwiftUI
import GoogleGenerativeAI

struct AIView: View {
    // MARK: - Properties
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "LOADING_MESSAGE_AI"
    @State var isLoading = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            WelcomeMessage()
            
            ZStack {
                ResponseView(response: response, isLoading: isLoading)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                        .padding()
                }
            }
            
            PromptInputView(userPrompt: $userPrompt) {
                generateResponse()
            }
        }
        .background(Color(.systemGray5).ignoresSafeArea())
    }
    
    // MARK: - Methods
    func generateResponse() {
        isLoading = true
        response = ""
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "NO_RESULT_MESSAGE_AI")
                userPrompt = ""
            } catch {
                response = "ERROR_MESSAGE_AI"
            }
        }
    }
}

#Preview {
    AIView()
}
