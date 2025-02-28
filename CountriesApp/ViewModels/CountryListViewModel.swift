//
//  CountryListViewModel.swift
//  CountriesApp
//

import Combine

/// `@MainActor` ensures that all updates to `@Published` properties occur on the main thread.
/// This is crucial because SwiftUI requires UI updates to be performed on the main thread.
@MainActor
class CountryListViewModel: ObservableObject {
    
    /// A list of fetched countries
    @Published var countries: [Country] = []
    
    /// A boolean flag to indicate whether data is currently being loaded.
    @Published var isLoading = false
    
    /// A string to store any error messages that might occur during data fetching.
    @Published var errorMessage: String?
    
    /// A dependency that handles fetching country data.
    /// Using a protocol allows for easier testing and dependency injection.
    private let countryService: CountryServiceProtocol
    
    /// Initializes the view model with a `CountryServiceProtocol` instance.
    /// - Parameter countryService: The service responsible for fetching country data.
    ///   Defaults to `CountryService()`, but can be replaced for testing.
    init(countryService: CountryServiceProtocol = CountryService()) {
        self.countryService = countryService
        /// Automatically fetch countries when the ViewModel is initialized.
        Task { await fetchCountries() }
    }
    
    /// Fetches the list of countries asynchronously.
    /// - Updates `isLoading` while fetching data.
    /// - Stores fetched data in `countries` or sets an `errorMessage` if an error occurs.
    func fetchCountries() async {
        isLoading = true
        errorMessage = nil
        
        /// `defer` ensures `isLoading` is set to `false` once the function exits,
        /// whether it succeeds or fails.
        defer { isLoading = false }
        
        do {
            /// Fetch countries from the service.
            countries = try await countryService.fetchCountries()
        } catch {
            /// Store the localized error message to be displayed.
            errorMessage = error.localizedDescription
        }
    }
}
