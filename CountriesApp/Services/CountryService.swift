//
//  CountryService.swift
//  CountriesApp
//

import Foundation

/// A protocol that defines the contract for fetching countries.
/// This allows for dependency injection and easier unit testing.
protocol CountryServiceProtocol {
    func fetchCountries() async throws -> [Country]
}

/// A concrete implementation of `CountryServiceProtocol` that fetches country data from a remote API.
class CountryService: CountryServiceProtocol {

    /// Fetches a list of countries asynchronously from a public REST API.
    /// - Returns: An array of `Country` objects if the request succeeds.
    /// - Throws: A `NetworkingError` if the request fails due to network issues or decoding errors.
    func fetchCountries() async throws -> [Country] {
        /// Define the API endpoint URL.
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            throw NetworkingError.unknown
        }
        
        /// Perform the network request using `URLSession.shared.data(from:)`
        let (data, response) = try await URLSession.shared.data(from: url)
        
        /// Ensure the response is a valid HTTP response and has a status code of 200 (OK).
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        
        /// Attempt to decode the response data into an array of `Country` objects.
        do {
            let countries = try JSONDecoder().decode([Country].self, from: data)
            return countries
        } catch {
            throw NetworkingError.decodingError
        }
    }
}

/// An enumeration representing possible network-related errors.
enum NetworkingError: Error, LocalizedError {
    case invalidResponse   // Occurs when the HTTP response is not valid (e.g., status code not 200)
    case decodingError     // Occurs when JSON decoding fails
    case unknown           // A fallback error for any other unexpected issues

    /// Provides user-friendly descriptions for each error case.
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Invalid response from server.", comment: "Invalid Response")
        case .decodingError:
            return NSLocalizedString("Failed to decode the data.", comment: "Decoding Error")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "Unknown Error")
        }
    }
}
