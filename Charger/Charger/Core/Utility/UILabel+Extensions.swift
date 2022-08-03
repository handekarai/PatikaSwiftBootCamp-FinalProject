//
//  UILabel+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/27/22.
//

import UIKit


extension UILabel {
    
    // returns uilabel with title and subtitle
    class func labelWithTitleAndSubtitle(title : String, subTitle : String) -> UILabel? {
        let titleParameters  = [NSAttributedString.Key.foregroundColor : UIColor.whiteColor, NSAttributedString.Key.font: Theme.navigationBarTitleFont]
        let subtitleParameters  = [NSAttributedString.Key.foregroundColor : UIColor.greyScaleColor, NSAttributedString.Key.font: Theme.navigationBarSubTitleFont]
        
        let title:NSMutableAttributedString = NSMutableAttributedString(string: title, attributes: titleParameters)
        let subtitle:NSMutableAttributedString = NSMutableAttributedString(string: "\n\(subTitle)", attributes: subtitleParameters)

        title.append(subtitle)
                
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.attributedText = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        return titleLabel
    }
}
