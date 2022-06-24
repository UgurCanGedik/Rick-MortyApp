//
//  MainViewModel.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import Foundation

class MainViewModel {

    static let shared = MainViewModel()

    private var page: Int = 1
    public var characterFilter: Observable<Filters?> = Observable(.allCharacters)
    public var characterData: Observable<[CharacterQuery.Data.Character.Result]> = Observable([])
    public var errorOccured: (()->())?

    init() { }

    func getData(isNextPage: Bool) {

        if isNextPage {
            page += 1
        } else {
            deleteValues()
        }

        Network.shared.apollo.fetch(query: CharacterQuery(page: page, charaterFilter: characterFilter.value ?? .allCharacters)) { [weak self] result in
            guard let self = self
            else { return }

            switch result {
            case .success(let graphQLResult):
                if let results = graphQLResult.data?.characters?.results {
                    self.characterData.value.append(contentsOf: results.compactMap { $0 })
                }
            case .failure( _):
                if let _errorOccured = self.errorOccured {
                    _errorOccured()
                }
            }
        }
    }

    private func deleteValues(){

        page = 1
        self.characterData.value = []
    }

    func getRowCount() -> Int {
        return characterData.value.count
    }
}
