//
//  Country.swift
//  CountriesApp
//

import Foundation

struct Country: Codable {
    let name: Name
    let flags: Flag
    let region: String
    let population: Int
    let capital: [String]?

    struct Name: Codable {
        let common: String
    }

    struct Flag: Codable {
        let png: String
    }
}
