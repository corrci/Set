//
//  SetCardDeck.swift
//  Set
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import Foundation

struct SetCarDeck {
    private(set) var cards = [SetCard]()
    init() {
        for number in SetCard.Variant.allCases{
            for color in SetCard.Variant.allCases{
                for shape in SetCard.Variant.allCases{
                    for fill in SetCard.Variant.allCases{
                        cards.append(SetCard(number: number,color: color, shape: shape, fill: fill))
                    }
                }
            }
        }
    }
    mutating func draw() -> SetCard?{
        if cards.count > 0{
            return cards.remove(at: Int.random(in: 0..<cards.count))
        }else{
            return nil
        }
    }
}

