//
//  String+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/7/22.
//

import Foundation
import UIKit

extension String {
    
    // checks e-mail is valid or not
    func isValidEmail() -> Bool {
     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    // changes specific part of text to greyscale
    func changeTextAttributesWithSpecificRange(with textLength: Int) -> NSMutableAttributedString {
        
        // color attribute
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.greyScaleColor]
  
        // create mutable attributed string & bold matching part
        let newAttributedText = NSMutableAttributedString(string: self)
        newAttributedText.setAttributes(attribute, range: NSMakeRange(0, textLength))
    
        return newAttributedText
    }
}
