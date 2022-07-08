//
//  String+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/7/22.
//

import Foundation

extension String {
    
    // checks e-mail is valid or not
    func isValidEmail() -> Bool {
     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
