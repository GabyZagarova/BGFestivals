//
//  RatingAlert.swift
//  bgfestivals
//
//  Created by Siyana Slavova on 3/21/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import UIKit

protocol RatingAlertDelegate: class {
    func ratingAlert(buttonTapped: RatingButton)
}

class RatingAlert: UIView {
    
    @IBOutlet weak var oneStarButton: RatingButton!
    @IBOutlet weak var twoStarsButton: RatingButton!
    @IBOutlet weak var threeStarsButton: RatingButton!
    
    weak var delegate: RatingAlertDelegate?
    
    var shown: Bool = false
    
    override func awakeFromNib() {
        backgroundColor = UIColor.init(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
        layer.cornerRadius = 10
    }
    
    @IBAction func ratingButtonTapped(_ sender: RatingButton) {
        delegate?.ratingAlert(buttonTapped: sender)
        if sender == oneStarButton {
            //todo handle 1 star
        }
        else if sender == twoStarsButton {
            //todo handle 2 stars
        }
        else if sender == threeStarsButton {
            //todo handle 3 stars
        }
    }
}
