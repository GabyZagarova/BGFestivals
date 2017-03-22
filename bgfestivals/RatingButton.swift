//
//  RatingButton.swift
//  bgfestivals
//
//  Created by Siyana Slavova on 3/22/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import UIKit

class RatingButton: UIButton {
    
    override func awakeFromNib() {        
        backgroundColor = UIColor.init(colorLiteralRed: 1, green: 233.0/255, blue: 97.0/255, alpha: 1)
        layer.borderWidth = 2
        layer.borderColor = UIColor.init(colorLiteralRed: 1, green: 203.0/255, blue: 0, alpha: 1).cgColor
        layer.cornerRadius = frame.size.width / 2
    }

}
