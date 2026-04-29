//
//  Country.swift
//  UIPickers
//
//  Plain value type for the country picker demo.
//  Notes:
//   - `struct` (not class) — picker rows are pure data, value semantics are right.
//   - `Hashable` lets us use it as a diffable identifier later if we move to UICollectionView.
//

import Foundation

struct Country: Hashable, Sendable {
    let name: String
    let isoCode: String   // e.g. "GE"
    let dialCode: String  // e.g. "+995"
    let flag: String      // emoji

    static let demoData: [Country] = [
        Country(name: "Georgia",        isoCode: "GE", dialCode: "+995", flag: "🇬🇪"),
        Country(name: "Germany",        isoCode: "DE", dialCode: "+49",  flag: "🇩🇪"),
        Country(name: "Greece",         isoCode: "GR", dialCode: "+30",  flag: "🇬🇷"),
        Country(name: "France",         isoCode: "FR", dialCode: "+33",  flag: "🇫🇷"),
        Country(name: "Italy",          isoCode: "IT", dialCode: "+39",  flag: "🇮🇹"),
        Country(name: "Spain",          isoCode: "ES", dialCode: "+34",  flag: "🇪🇸"),
        Country(name: "United Kingdom", isoCode: "GB", dialCode: "+44",  flag: "🇬🇧"),
        Country(name: "United States",  isoCode: "US", dialCode: "+1",   flag: "🇺🇸"),
        Country(name: "Japan",          isoCode: "JP", dialCode: "+81",  flag: "🇯🇵"),
        Country(name: "Türkiye",        isoCode: "TR", dialCode: "+90",  flag: "🇹🇷"),
    ]
}
