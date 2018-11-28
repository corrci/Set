//
//  ViewController.swift
//  Set
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [BorderButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
    }
    func updateButtonsFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle(String(index), for: .normal)
            if index < 12{
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
}

