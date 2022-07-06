//
//  UITextField+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/6/22.
//

import UIKit

extension UITextField {
    
    // adds only underline to text field
    func addUnderLine () {
        let bottomLine = CALayer()
        // underline properties
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height, width: self.bounds.width - 18, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
