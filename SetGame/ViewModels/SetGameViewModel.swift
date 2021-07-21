//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by krkota on 14/07/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private(set) var model = SetGameModel()
    
    init() {
        loadNewGame()
    }
    
    func choose(_ card: SetGameModel.Card) {
        model.choose(card)
    }
    
    func dealCards(upto: Int) {
        model.dealCards(upto: upto)
    }
    
    func loadNewGame() {
        self.model = SetGameModel()
        model.dealCards(upto: 12)
    }
}

enum ContentShape: CaseIterable {
    case capsule, diamond, star
}

enum ContentColor: CaseIterable {
    case red, blue, green
}

enum ContentFill: CaseIterable {
    case none, striped, solid
}
