//
//  CountryListView.swift
//  CountriesApp
//

import SwiftUI

/// A view that displays a list of countries fetched from a remote API.
struct CountryListView: View {
    /// The view model that handles fetching and managing the list of countries.
    @StateObject var viewModel = CountryListViewModel()

    var body: some View {
        /// Displays a loading indicator when data is being fetched.
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        }
        /// Displays an error message with a retry button if an error occurs.
        else if let error = viewModel.errorMessage, viewModel.countries.isEmpty {
            ErrorView(error: error) {
                /// Initiates data fetching when the retry button is tapped.
                Task { await viewModel.fetchCountries() }
            }
        }
        /// Displays the list of countries once data is successfully loaded.
        else {
            List(viewModel.countries, id: \.name.common) { country in
                /// Navigates to the detail view when a country is selected.
                NavigationLink(destination: CountryDetailView(country: country)) {
                    CountryCellView(flag: country.flags.png, name: country.name.common)
                }
            }
            .navigationTitle("Pays du monde") /// Sets the title of the navigation bar.
        }
    }
}
