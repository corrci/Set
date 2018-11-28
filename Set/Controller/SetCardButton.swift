//
//  SetCardButton.swift
//  Set
//
//  Created by corrci on 2018/11/29.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

@IBDesignable class SetCardButton: BorderButton {
    
    var colors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    var alphas: [CGFloat] = [1.0, 0.40, 0.15]
    var strokeWidths: [CGFloat] = [-8, -8, -8]
    var symbols = ["●", "▲", "■"]
    
    var setCard: SetCard? {didSet {updateButton()}}
    
    var verticalsizeClass: UIUserInterfaceSizeClass{ return UIScreen.main.traitCollection.verticalSizeClass}
    
    private func setAttributedString(card: SetCard) -> NSAttributedString{
        //symbols: number & shape
        let symbol = symbols[card.shape.idx]
        let separator = verticalsizeClass == .regular ? "\n" : ""
        let symbolsString = symbol.join(n: card.number.idx, with: separator)
        //attributes: color & fill
        let attributes:[NSAttributedString.Key : Any] = [
            .strokeColor: colors[card.color.idx],
            .strokeWidth: strokeWidths[card.fill.idx],
            .foregroundColor: colors[card.color.idx].withAlphaComponent(alphas[card.fill.idx])
        ]
        return NSAttributedString(string: symbolsString, attributes: attributes)
    }
    
    private func updateButton(){
        if let card = setCard{ //user can touch
            let attributedString = setAttributedString(card: card)
            setAttributedTitle(attributedString, for: .normal)
            backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            isEnabled = true
        }else{ //user can't see and touch
            setAttributedTitle(nil, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            isEnabled = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure () {
        cornerRadius = Constants.connerRadius
        titleLabel?.numberOfLines = 0
        borderColor = Constants.borderColor
        borderWidth = -Constants.borderWidth
    }
    
    func setBorderColor(color: UIColor){
        borderColor = color
        borderWidth = Constants.borderWidth
    }
    
    //constants
    struct Constants {
        static let connerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 5.0
        static let borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
}



extension String {
    func join(n: Int, with separator: String) -> String{
        guard n > 1 else {return self}
        var symbol = [String]()
        for _ in 0..<n {
            symbol += [self]
        }
        return symbol.joined(separator: separator)
    }
}
