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
    
    private(set) var cardsOnTable = [SetCard]()
    private(set) var cardsSelected = [SetCard]()
    private(set) var cardsTryMatched = [SetCard]()
    private(set) var cardsRemoved = [SetCard]()
    
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
    
    private mutating func deal3(){
        if let deal3Cards = take3FromDeck(){
            cardsOnTable = deal3Cards
        }
    }
    
    private mutating func replaceOrRemove3Cards(){
        if let take3Cards = take3FromDeck(){
            cardsOnTable.replace(elements: cardsTryMatched, with: take3Cards)
        }else{
            cardsOnTable.remove(elements: cardsTryMatched)
        }
        cardsRemoved += cardsTryMatched
        cardsTryMatched.removeAll()
    }
    
    var isSet: Bool?{
        get{
            guard cardsTryMatched.count == 3 else { return nil }
            return SetCard.isSet(cards: cardsTryMatched)
        }
        set{
            if newValue != nil{
                if newValue!{
                    cardsTryMatched = cardsSelected
                    cardsSelected.removeAll()
                }else{
                    cardsTryMatched.removeAll()
                }
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cardsOnTable.indices.contains(index),"SetGame.chooseCard(at: \(index)) : Choosen index out of range")
        let cardChoosen = cardsOnTable[index]
        if !cardsRemoved.contains(cardChoosen) && !cardsTryMatched.contains(cardChoosen){
            if isSet != nil{
                if isSet! { replaceOrRemove3Cards() }
                    isSet = nil
            }
            if cardsSelected.count == 2, !cardsSelected.contains(cardChoosen){
                cardsSelected += [cardChoosen]
                isSet = SetCard.isSet(cards: cardsSelected)
            }else{
                cardsSelected.inOut(element: cardChoosen)
            }
        }
    }
}

extension Array where Element : Equatable {
    /// change the element of Array:
    /// check if contain take out, else append
    mutating func inOut(element: Element){
        if let from = self.index(of:element)  {
            self.remove(at: from)
        } else {
            self.append(element)
        }
    }
    
    mutating func remove(elements: [Element]){
        /// delete the element of Array
        self = self.filter { !elements.contains($0) }
    }
    
    mutating func replace(elements: [Element], with new: [Element] ){
        /// if [new].count == [old].count, replace all elements
        guard elements.count == new.count else {return}
        for idx in 0..<new.count {
            if let indexMatched = self.index(of: elements[idx]){
                self[indexMatched] = new[idx]
            }
        }
    }
    
    func indices(of elements: [Element]) ->[Int]{
        guard self.count >= elements.count, elements.count > 0 else {return []}
        /// return same element's [index]
        return elements.map{self.index(of: $0)}.compactMap{$0}
    }
    
}
