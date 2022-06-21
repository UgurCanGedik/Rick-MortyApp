//
//  Network.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import Apollo
import Foundation

class Network {

    static let shared = Network()
    lazy var apollo = ApolloClient(url: baseAPPURL)
}

