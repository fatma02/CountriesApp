//
//  ErrorView.swift
//  CountriesApp
//

import SwiftUI

/// A reusable view that displays an error message and provides a retry button.
struct ErrorView: View {
    /// The error message to display.
    let error: String
    /// A closure that executes when the retry button is tapped.
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            /// Displays the error message in red to indicate an issue.
            Text(error)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()

            /// A retry button that calls the provided `retryAction` closure.
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

