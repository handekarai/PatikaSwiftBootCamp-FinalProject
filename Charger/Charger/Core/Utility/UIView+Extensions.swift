//
//  UIView+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/6/22.
//

import UIKit

extension UIView{
    
    // adds specific gradient to view
    func addGradient () {
        let colorTop =  UIColor(red: 0.24, green: 0.26, blue: 0.31, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.08, green: 0.09, blue: 0.12, alpha: 1.00).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
