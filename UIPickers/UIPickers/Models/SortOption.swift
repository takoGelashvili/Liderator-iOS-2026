//
//  SortOption.swift
//  UIPickers
//
//  Domain enum for the menu demo. Conforms to CaseIterable so the
//  menu builder can enumerate all options without us hard-coding a list.
//

import UIKit

enum SortOption: String, CaseIterable, Identifiable {
    case name
    case dateAdded
    case priceAscending
    case priceDescending

    var id: String { rawValue }

    var title: String {
        switch self {
        case .name:             return "Name (A–Z)"
        case .dateAdded:        return "Date added"
        case .priceAscending:   return "Price ↑"
        case .priceDescending:  return "Price ↓"
        }
    }

    var systemImageName: String {
        switch self {
        case .name:             return "textformat"
        case .dateAdded:        return "calendar"
        case .priceAscending:   return "arrow.up"
        case .priceDescending:  return "arrow.down"
        }
    }
}
