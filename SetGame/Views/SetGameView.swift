//
//  SetGameView.swift
//  SetGame
//
//  Created by krkota on 13/07/21.
//

import SwiftUI

struct SetGameView: View {
    var setGameViewModel = SetGameViewModel()
    
    var body: some View {
        NavigationView {
            CardsListView(setGameViewModel: setGameViewModel)
                .navigationBarTitle(Text("Set"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            setGameViewModel.loadNewGame()
                        }, label: {
                            Text("New Game")
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            setGameViewModel.dealCards(upto: 3)
                        }, label: {
                            Text("Deal Cards")
                        })
                    }
                }
        }
    }
}

struct CardsListView: View {
    @ObservedObject var setGameViewModel: SetGameViewModel
    
    var body: some View {
        AspectVGrid(items: setGameViewModel.model.dealtCards, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .onTapGesture {
                    setGameViewModel.choose(card)
                }
                .padding(4)
        })
    }
}

struct CardView: View {
    let card: SetGameModel.Card
    
    var body: some View {
        let cardShape = RoundedRectangle(cornerRadius: SetGameViewConstants.cardCornerRadius)
        let color = getColor()
        let opacity = card.isSelected ? 0.2 : 1
        
        ZStack {
            // white bg
            cardShape.fill().foregroundColor(.white)
            
            // colored border
            cardShape
                .strokeBorder(lineWidth: SetGameViewConstants.cardLineWidth)
                .foregroundColor(color)
                .opacity(opacity)
            
            // card content
            GeometryReader { geometry in
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ForEach(0..<card.number, id: \.self) { _ in
                            CardContentView(cardItem: ShapeFinder(shape: card.shape), color: color, fill: card.fill)
                                .frame(width: geometry.size.width/3, height: geometry.size.height/6, alignment: .center)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .opacity(opacity)
        }
    }
    
    struct CardContentView: View {
        let cardItem: ShapeFinder
        let color: Color
        let fill: ContentFill
        
        var body: some View {
            switch fill {
            case .none:
                ZStack {
                    cardItem.fill().foregroundColor(.white)
                    cardItem.stroke(lineWidth: 2).foregroundColor(color)
                }
            case .striped:
                StripedView(content: cardItem, color: color)
            case .solid:
                cardItem.fill().foregroundColor(color)
            }
        }
    }
    
    struct StripedView<Content>: View where Content: Shape {
        let numberOfStrips: Int = 5
        let lineWidth: CGFloat = 2
        let borderLineWidth: CGFloat = 2
        let content: Content
        let color: Color
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(0..<numberOfStrips) { number in
                    Color.white
                    color.frame(width: lineWidth)
                    if number == numberOfStrips - 1 {
                        Color.white
                    }
                }
                
            }.mask(content)
            .overlay(content.stroke(color, lineWidth: borderLineWidth))
        }
    }
    
    struct ShapeFinder: Shape, Identifiable {
        let shape: ContentShape
        let id = UUID()
        
        func path(in rect: CGRect) -> Path {
            switch shape {
            case .capsule:
                return Capsule().path(in: rect)
            case .diamond:
                return DiamondShape().path(in: rect)
            case .star:
                return StarShape().path(in: rect)
            }
        }
    }
    
    func getColor() -> Color {
        switch card.color {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        }
    }
}

struct SetGameViewConstants {
    static let cardCornerRadius: CGFloat = 10
    static let padding4: CGFloat = 4
    static let cardLineWidth: CGFloat = 4
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
            .preferredColorScheme(.dark)
        
        SetGameView()
    }
}

