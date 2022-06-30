//
//  Enums.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import Foundation

enum Filters: CustomStringConvertible {

    case ricks
    case mortys
    case summer
    case allCharacters

    var description : String {
        switch self {
        case .ricks:
            return "rick"
        case .mortys:
            return "morty"
        case .summer:
            return "summer"
        case .allCharacters:
            return ""
        }
    }
}
