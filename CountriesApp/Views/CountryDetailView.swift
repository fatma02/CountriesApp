//
//  CountryDetailView.swift
//  CountriesApp
//

import SwiftUI

/// A view that displays detailed information about a selected country.
struct CountryDetailView: View {
    /// The country data to display.
    let country: Country

    var body: some View {
        VStack(spacing: 20) {
            /// Displays the country’s flag asynchronously.
            AsyncImage(url: URL(string: country.flags.png)) { image in
                image
                    .resizable() /// Makes the image resizable.
                    .scaledToFit() /// Maintains aspect ratio.
            } placeholder: {
                /// Shows a loading indicator while the image is being fetched.
                ProgressView()
            }
            .frame(width: 250, height: 150) /// Sets a fixed size for the flag image.

            /// Displays the country name in a large, bold font.
            Text(country.name.common)
                .font(.largeTitle)
                .bold()

            /// Displays additional details about the country.
            Text("Continent : \(country.region)")
                .fontWeight(.semibold)

            Text("Population : \(country.population)")
                .fontWeight(.semibold)

            /// Displays the capital city, if available; otherwise, shows "N/A".
            Text("Capitale : \(country.capital?.first ?? "N/A")")
                .fontWeight(.semibold)

            Spacer() /// Pushes content to the top for better spacing.
        }
        .padding() /// Adds padding around the content.
        .navigationTitle(country.name.common) /// Sets the navigation bar title.
    }
}
