//
//  UnderlineStyleTextField.swift
//  iSpend
//
//  Created by Gabriela Zagarova on 6/23/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import Foundation
import UIKit

class UnderlineStyleTextField: UITextField {
    
    var fontSize: CGFloat {
        let horizontalSizeClass = self.traitCollection.horizontalSizeClass
        switch (horizontalSizeClass) {
        case .regular:
            return 16.0
        default :
            return 18.0
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 5)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

extension UnderlineStyleTextField {
    
    func applyUnderlineStyleTextField(icon: UIImage? = nil) {
        self.font = UIFont.systemFont(ofSize: self.fontSize)
        
        if let leftIcon = icon {
            self.leftViewMode = UITextFieldViewMode.always
            let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height - 16, height: self.frame.size.height - 16))
            leftImageView.image = leftIcon
            self.leftView = leftImageView
        }
        
        self.setBottomBorder()
    }
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
