//
//  CountryCellView.swift
//  CountriesApp
//

import SwiftUI

/// A reusable view that displays a country's flag and name.
struct CountryCellView: View {
    /// The URL string of the country's flag image.
    let flag: String
    
    /// The common name of the country.
    let name: String

    var body: some View {
        HStack {
            /// Loads and displays the flag image asynchronously.
            AsyncImage(url: URL(string: flag)) { image in
                image
                    .resizable() /// Makes the image resizable to fit within the frame.
                    .scaledToFit() /// Ensures the image maintains its aspect ratio.
            } placeholder: {
                /// Displays a loading indicator while waiting for the image to be fetched.
                ProgressView()
            }
            .frame(width: 60, height: 40) /// Sets a fixed size for the flag image.

            /// Displays the country name next to the flag.
            Text(name)
        }
    }
}
