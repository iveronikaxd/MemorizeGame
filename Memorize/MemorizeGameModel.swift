//
//  MemorizeGameModel.swift
//  Memorize
//
//  Created by Veronika Horovenko on 02.10.2025.
//

import Foundation

struct MemorizeGameModel<CardContent> where CardContent: Equatable {

    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        shuffleCards()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        matched()
                    } else {
                        mismatched(card1: cards[chosenIndex], card2: cards[potentialMatchIndex])
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating private func shuffleCards() {
        cards.shuffle()
    }
    
    mutating private func matched() {
        score += 2
    }
    
    mutating private func mismatched(card1: Card, card2: Card) {
        score -= card1.isPreviouslySeen && card2.isPreviouslySeen ? 2 : card1.isPreviouslySeen || card2.isPreviouslySeen ? 1 : 0
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false {
            didSet {
                print("\(content) \(id) isFaceUp - \(isFaceUp) (oldValue - \(oldValue)")
                if !isFaceUp && oldValue == true {
                    isPreviouslySeen = true
                }
            }
        }
        var isMatched = false
        let content: CardContent
        
        var isPreviouslySeen: Bool = false
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? self.first : nil
    }
    
}
