//
//  ViewController.swift
//  Set
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = SetGame()
    
    var colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    var stokeWidths: [CGFloat] = [-10, -10, 10]
    var alphas: [CGFloat] = [1.0, 0.60, 0.15]

    @IBOutlet var cardButtons: [SetCardButton]!{
        didSet{
            for button in cardButtons{
                button.strokeWidths = stokeWidths
                button.colors = colors
                button.alphas = alphas
            }
        }
    }
    
    @IBAction func touchCard(_ sender: SetCardButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateButtonsFromModel()
        }else{
            print("choosen card was not in cardButtons")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
    }
    
    func updateButtonsFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            if index < game.cardsOnTable.count{
                let card = game.cardsOnTable[index]
                button.setCard = card
                //selected
                button.setBorderColor(color: game.cardsSelected.contains(card) ? Colors.seleced : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
                //try matched
                if let itIsSet = game.isSet{
                    if game.cardsTryMatched.contains(card){
                        button.setBorderColor(color: itIsSet ? Colors.matched : Colors.misMatched)
                    }
                }
            }else{
                button.setCard = nil
            }
        }
    }
    private struct Colors{
        static let hit = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        static let seleced = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        static let matched = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        static let misMatched = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    }
}

