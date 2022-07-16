//
//  UINavigationBar+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import UIKit

extension UINavigationBar {
   
    //sets navigation bar appearance to avoid different appearance which comes with ios15
    func addAppearance () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.charcoalGrey
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        self.standardAppearance = appearance;
        if #available(iOS 15.0, *) { // For compatibility with earlier iOS.
            self.scrollEdgeAppearance = self.standardAppearance
        }
    }
}
