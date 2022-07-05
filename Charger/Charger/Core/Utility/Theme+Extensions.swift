//
//  Style+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 6/30/22.
//
import UIKit

extension UIColor {
    //time slot seleted, text field bg color
    static var darkColor: UIColor{
        return UIColor(red: 0.10, green: 0.12, blue: 0.15, alpha: 1.00)
    }
    //navbar, profile card, popup bg, dark button
    static var charcoalGrey: UIColor {
        return UIColor(red: 0.26, green: 0.29, blue: 0.33, alpha: 1.00)
    }
    static var greyScaleColor: UIColor {
        return UIColor(red: 0.72, green: 0.74, blue: 0.80, alpha: 1.00)
    }
    //text field border, slider, time slot border, filter
    static var primaryColor: UIColor{
        return UIColor(red: 0.00, green: 1.00, blue: 0.00, alpha: 1.00)
    }
    //text field border
    static var securityOnColor: UIColor{
        return UIColor(red: 1.00, green: 0.17, blue: 0.33, alpha: 1.00)
    }
    //white texts, buttons, icon
    static var whiteColor: UIColor {
        return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    static var navigationBarSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
    static var bodyTitle: UIFont {
        return UIFont.systemFont(ofSize: 18 , weight: .bold)
    }
    static var bodySubtitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
    static var bodyHeadLine: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    static var cityListItem: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var button: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    static var stationCardTitle: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    static var stationCardSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .light)
    }
    static var stationCardBody: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    static var socketSlotTitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    static var socketSlotSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .light)
    }
    static var popUpTitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    static var popUpSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    static var appointmentDetailSectionTitle: UIFont {
        return UIFont.systemFont(ofSize: 15 , weight: .semibold)
    }
    static var appointmentDetailInfoTitle: UIFont {
        return UIFont.systemFont(ofSize: 14 , weight: .semibold)
    }
    static var appointmentDetailInfoSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
}
