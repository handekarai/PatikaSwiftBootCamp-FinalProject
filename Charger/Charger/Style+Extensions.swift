//
//  Style+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 6/30/22.
//
import UIKit

extension UIColor {
    static var backgroundColor: UIColor {
        return UIColor(red: 0.24, green: 0.27, blue: 0.31, alpha: 1.00)
    }
    //navbar, profile card, popup bg, dark button
    static var lightGray: UIColor {
        return UIColor(red: 0.26, green: 0.29, blue: 0.33, alpha: 1.00)
    }
    //text field bg color
    static var searchTextFieldBgColor: UIColor {
        return UIColor(red: 0.10, green: 0.12, blue: 0.15, alpha: 1.00)
    }
    //white texts, buttons, icon
    static var whiteColor: UIColor {
        return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
    //dark button text
    static var darkColor: UIColor{
        return UIColor(red: 0.07, green: 0.08, blue: 0.14, alpha: 1.00)
    }
    //MARK: change after design
    //for the first card, others are much darker,also appointment card color
    static var stationCardBgColor: UIColor{
        return UIColor(red: 0.23, green: 0.25, blue: 0.30, alpha: 1.00)
    }
    //text field border, slider, time slot border, filter
    static var greenColor: UIColor{
        return UIColor(red: 0.31, green: 1.00, blue: 0.00, alpha: 1.00)
    }
    //text field border
    static var redColor: UIColor{
        return UIColor(red: 0.51, green: 0.25, blue: 0.26, alpha: 1.00)
    }
    //time slot seleted
    static var darkerColor: UIColor{
        return UIColor(red: 0.03, green: 0.03, blue: 0.04, alpha: 1.00)
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    static var navigationBarSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
    static var bodyTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var bodySubtitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var bodyHeadLine: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var cityListItem: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var button: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var stationCardTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var stationCardSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var stationCardBody: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var socketSlotTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var socketSlotSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var popUpTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var popUpSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var appointmentDetailSectionTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var appointmentDetailInfoTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var appointmentDetailInfoSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
}
