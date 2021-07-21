//
//  SetGameModel.swift
//  SetGame
//
//  Created by krkota on 14/07/21.
//

import Foundation

struct SetGameModel {
    private(set) var deck: [Card]
    private(set) var dealtCards: [Card]
    private(set) var selectedCards: [Card]
    
    init() {
        deck = [Card]()
        dealtCards = [Card]()
        selectedCards = [Card]()
        
        for shape in ContentShape.allCases {
            for color in ContentColor.allCases {
                for number in 1...3 {
                    for fill in ContentFill.allCases {
                        deck.append(Card(shape: shape, color: color, number: number, fill: fill, isSelected: false))
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenCardIndex = dealtCards.firstIndex(where: { $0.id == card.id }) {
            if dealtCards[chosenCardIndex].isSelected {
                dealtCards[chosenCardIndex].isSelected = false
                if let selectedCardIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
                    selectedCards.remove(at: selectedCardIndex)
                }
            } else if selectedCards.count < 3 {
                dealtCards[chosenCardIndex].isSelected.toggle()
                selectedCards.append(card)
                
                if matchSelectedCards() {
                    for selectedCard in selectedCards {
                        if let selectedCardIndex = dealtCards.firstIndex(where: { $0.id == selectedCard.id }) {
                            dealtCards.remove(at: selectedCardIndex)
                        }
                    }
                    
                    selectedCards = [Card]()
                    dealCards(upto: 3)
                } else if selectedCards.count == 3 {
                    while selectedCards.count > 1 {
                        if let dealtCardIndex = dealtCards.firstIndex(where: { $0.id == selectedCards[0].id }) {
                            dealtCards[dealtCardIndex].isSelected = false
                            selectedCards.remove(at: 0)
                        }
                    }
                }
            }
        }
    }
    
    
    /// Function to check if the selected cards form a set
    /// - Returns: true if selected 3 cards form a set
    mutating func matchSelectedCards() -> Bool {
        if selectedCards.count == 3 {
            let sameShape = selectedCards[0].shape == selectedCards[1].shape
                && selectedCards[1].shape == selectedCards[2].shape
            
            let sameColor = selectedCards[0].color == selectedCards[1].color
                && selectedCards[1].color == selectedCards[2].color
            
            let sameNumber = selectedCards[0].number == selectedCards[1].number
                && selectedCards[1].number == selectedCards[2].number
            
            let sameFill = selectedCards[0].fill == selectedCards[1].fill
                && selectedCards[1].fill == selectedCards[2].fill
            
            // 0 same, 4 diff -> 0000
            // 1 same, 3 diff -> 1000, 0100, 0010, 0001
            // 2 same, 2 diff -> 1100, 1010, 1001, 0110, 0101, 0011
            // 3 same, 1 diff -> 1110, 1011, 1101, 0111
            
            var val = 0
            if sameShape {
                val |= 8
            }
            if sameColor {
                val |= 4
            }
            if sameNumber {
                val |= 2
            }
            if sameFill {
                val |= 1
            }
            
            return val > 0
        }
        
        return false
    }
    
    mutating func dealCards(upto: Int) {
        if deck.count > 0 {
            let min = min(deck.count-1, upto-1)
            for _ in 0...min {
                let card = deck.remove(at: 0)
                dealtCards.append(card)
            }
        }
    }
    
    struct Card: Identifiable {
        let shape: ContentShape
        let color: ContentColor
        let number: Int
        let fill: ContentFill
        let id = UUID()
        
        var isSelected: Bool
    }
}
