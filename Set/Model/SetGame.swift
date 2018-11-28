//
//  SetGame.swift
//  Set
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import Foundation

struct SetGame {
    var playrIndex = 0
    
    private(set) var flipCout = [0,0]
    private(set) var score = [0,0]
    private(set) var numberSets = [0,0]
    
    private(set) var cardOnTable = [SetCard]()
    private(set) var cardSelected = [SetCard]()
    private(set) var cardMatched = [SetCard]()
    private(set) var cardRemoved = [SetCard]()
    
    private var deck = SetCarDeck()
    var deckCount: Int { return deck.cards.count }
    
    private mutating func take3FromDeck() -> [SetCard]?{
        var threeCards = [SetCard]()
        for _ in 0...2 {
            if let card = deck.draw(){
                threeCards += [card]
            }else{
                return nil
            }
        }
        return threeCards
    }
}
