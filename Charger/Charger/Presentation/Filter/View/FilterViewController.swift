//
//  FilterViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var deviceTypeLabel: UILabel!
    @IBOutlet weak var deviceTypeAcButton: UIButton!
    @IBOutlet weak var deviceTypeDcButton: UIButton!
    @IBOutlet weak var socketTypeLabel: UILabel!
    @IBOutlet weak var socketTypeTypeTwoButton: UIButton!
    @IBOutlet weak var socketTypeCscButton: UIButton!
    @IBOutlet weak var socketTypeChademoButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var serviceCarParkButton: UIButton!
    @IBOutlet weak var serviceBuffetButton: UIButton!
    @IBOutlet weak var serviceWiFiButton: UIButton!
    
    var filter: Filter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // filter image has not given in assets for that reason i put "line.horizontal.3.decrease" image, it looks like filter image
        navigationBarItem.rightBarButtonItem = UIBarButtonItem(title: "TEMİZLE", style: .done, target: self, action: #selector(resetFilter(_:)))
        navigationBarItem.rightBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        navigationBarItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0, weight: .medium)], for: .normal)
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // device type label color and font
        deviceTypeLabel.textColor = Theme.bodyTitleColor
        deviceTypeLabel.font = Theme.bodyTitleFont
        
        // ac button background and border color
        addColorAndBorderToButton(deviceTypeAcButton)
        
        // dc button background and border color
        addColorAndBorderToButton(deviceTypeDcButton)

        
        // socket type label color and font
        socketTypeLabel.textColor = Theme.bodyTitleColor
        socketTypeLabel.font = Theme.bodyTitleFont
        
        // socketTypeTypeTwoButton background and border color
        addColorAndBorderToButton(socketTypeTypeTwoButton)
        
        // socketTypeCscButton background and border color
        addColorAndBorderToButton(socketTypeCscButton)
        
        // socketTypeChademoButton background and border color
        addColorAndBorderToButton(socketTypeChademoButton)

        // device type label color and font
        distanceLabel.textColor = Theme.bodyTitleColor
        distanceLabel.font = Theme.bodyTitleFont
        
        // device type label color and font
        servicesLabel.textColor = Theme.bodyTitleColor
        servicesLabel.font = Theme.bodyTitleFont

        // serviceCarParkButton background and border color
        addColorAndBorderToButton(serviceCarParkButton)
        
        // serviceBuffetButton background and border color
        addColorAndBorderToButton(serviceBuffetButton)
        
        // serviceWiFiButton background and border color
        addColorAndBorderToButton(serviceWiFiButton)

    }
    
    private func addColorAndBorderToButton(_ button: UIButton) {
        
        button.tintColor = UIColor.clear
        button.layer.borderColor = UIColor.whiteColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = deviceTypeDcButton.frame.size.height * 0.5
    }

    // reset filter
    @objc func resetFilter(_ sender: UIBarButtonItem) {}
    
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deviceTypeAcButtonTapped(sender: UIButton) {
        // if it is not chosen
        if sender.tintColor == UIColor.clear{
            sender.tintColor = UIColor.darkColor
            sender.layer.borderColor = UIColor.primaryColor.cgColor
        } else {
            // if it is already chosen
            sender.tintColor = UIColor.clear
            sender.layer.borderColor = UIColor.whiteColor.cgColor
        }
        
        switch sender {
        case deviceTypeAcButton:
            sender.tintColor == UIColor.darkColor ? filter?.chargeType?.append(ChargeType.ac) : filter?.chargeType?.removeAll(where: { $0 == ChargeType.ac})
        case deviceTypeDcButton:
            sender.tintColor == UIColor.darkColor ? filter?.chargeType?.append(ChargeType.dc) : filter?.chargeType?.removeAll(where: { $0 == ChargeType.dc})
        case socketTypeTypeTwoButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType?.append(SocketType.type2) : filter?.socketType?.removeAll(where: { $0 == SocketType.type2})
        case socketTypeCscButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType?.append(SocketType.csc) : filter?.socketType?.removeAll(where: { $0 == SocketType.csc})
        case socketTypeChademoButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType?.append(SocketType.chademo) : filter?.socketType?.removeAll(where: { $0 == SocketType.chademo})
        case serviceCarParkButton:
            sender.tintColor == UIColor.darkColor ? filter?.service?.append(Service.carPark) : filter?.service?.removeAll(where: { $0 == Service.carPark})
        case serviceBuffetButton:
            sender.tintColor == UIColor.darkColor ? filter?.service?.append(Service.buffet) : filter?.service?.removeAll(where: { $0 == Service.buffet})
        case serviceWiFiButton:
            sender.tintColor == UIColor.darkColor ? filter?.service?.append(Service.wifi) : filter?.service?.removeAll(where: { $0 == Service.wifi})
        default:
            break
        }
    }
    
}
