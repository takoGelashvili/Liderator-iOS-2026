//
//  Model + Extention.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import SwiftUI

extension Student {
    var gpaColor: Color {
        if gpa >= 3.3 {
            return .green
        } else if gpa >= 2.5 {
            return .yellow
        } else {
            return .red
        }
    }
}

extension Faculty.FacultyType  {
    var color: Color {
        switch self {
        case .macs(let school):
            switch school {
            case .sauketeso: return .purple
            case .enginner: return .cyan
            case .gaji: return .brown
            }
        case .esm: return .yellow
        case .vasds(let school):
            switch school {
            case .architecture: return .orange
            case .design: return .pink
            case .visualArt: return .teal
            }
        case .martva: return .indigo
        case .law: return .red
        case .aziaAfrika: return .mint
        case .physics: return .green
        }
    }
}

extension Faculty.FacultyType {
    var rawValue: String {
        switch self {
        case .macs(let school):
            switch school {
            case .sauketeso: return "CS"
            case .enginner: return "ECE"
            case .gaji: return "GAJI"
            }
        case .esm: return "ESM"
        case .vasds(let school):
            switch school {
            case .architecture: return "Architecture"
            case .design: return "Design"
            case .visualArt: return "Visual arts"
            }
        case .martva: return "Martva"
        case .law: return "Law"
        case .aziaAfrika: return "Azia afrika"
        case .physics: return "Physics"
        }
    }
}
