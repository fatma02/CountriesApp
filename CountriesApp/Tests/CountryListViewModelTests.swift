//
//  CountryListViewModelTests.swift
//  CountriesAppTests
//

import XCTest
@testable import CountriesApp

/// This test class ensures that `CountryListViewModel` behaves correctly when fetching countries.
@MainActor
class CountryListViewModelTests: XCTestCase {
    var viewModel: CountryListViewModel!  // The ViewModel instance being tested.
    var mockService: MockCountryService!  // A mock implementation of `CountryServiceProtocol`.

    /// Sets up the test environment before each test runs.
    override func setUp() {
        super.setUp()
        mockService = MockCountryService()  // Initialize the mock service.
        viewModel = CountryListViewModel(countryService: mockService)  // Inject the mock service.
    }

    /// Cleans up after each test to prevent shared state issues.
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    /// Tests that `fetchCountries()` successfully fetches and stores a list of countries.
    func testFetchCountries_Success() async {
        // Arrange: Create a mock list of countries.
        let mockCountries = [
            Country(name: Country.Name(common: "Canada"),
                    flags: Country.Flag(png: "https://flagcdn.com/w320/ca.png"),
                    region: "Americas",
                    population: 38_005_238,
                    capital: ["Ottawa"]),
                    
            Country(name: Country.Name(common: "Tunisia"),
                    flags: Country.Flag(png: "https://flagcdn.com/w320/tn.png"),
                    region: "Africa",
                    population: 11_818_618,
                    capital: ["Tunis"])
        ]
        mockService.mockCountries = mockCountries  // Inject mock data.

        // Call the function under test.
        await viewModel.fetchCountries()

        // Assert: Verify the expected outcome.
        XCTAssertEqual(viewModel.countries.count, 2, "Expected 2 countries but found \(viewModel.countries.count)")
        XCTAssertEqual(viewModel.countries.first?.name.common, "Canada", "First country should be Canada")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after completion")
    }

    /// Tests that `fetchCountries()` properly handles errors and updates state accordingly.
    func testFetchCountries_Failure() async {
        // Arrange: Simulate an error scenario.
        mockService.shouldThrowError = true

        // Act: Call the function under test.
        await viewModel.fetchCountries()

        // Assert: Verify that error handling works as expected.
        XCTAssertTrue(viewModel.countries.isEmpty, "Countries array should be empty on failure")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil when an error occurs")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after failure")
    }
}

/// **Mock Service for Testing**
/// A fake implementation of `CountryServiceProtocol` that allows controlled test behavior.
class MockCountryService: CountryServiceProtocol {
    var shouldThrowError: Bool = false  // Determines whether the mock should throw an error.
    var mockCountries: [Country] = []   // Holds predefined mock country data.

    /// Simulates fetching countries, either returning mock data or throwing an error.
    func fetchCountries() async throws -> [Country] {
        if shouldThrowError {
            throw NetworkingError.invalidResponse  // Simulate a network error.
        }
        return mockCountries  // Return predefined mock data.
    }
}
