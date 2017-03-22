//
//  TextFieldTableViewCell.swift
//  bgfestivals
//
//  Created by Gabriela Zagarova on 3/21/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    var isTitle: Bool? {
        didSet {
            if isTitle == false {
                textField.font = UIFont.systemFont(ofSize: 18.0)
            }
        }
    }

}
