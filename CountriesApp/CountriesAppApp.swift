//
//  CountriesAppApp.swift
//  CountriesApp
//

import SwiftUI

@main
struct CountriesAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CountryListView()
            }
        }
    }
}
