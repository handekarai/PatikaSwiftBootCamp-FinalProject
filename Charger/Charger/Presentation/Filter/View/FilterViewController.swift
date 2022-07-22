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
    @IBOutlet weak var distanceSliderValue: UISlider!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var serviceCarParkButton: UIButton!
    @IBOutlet weak var serviceBuffetButton: UIButton!
    @IBOutlet weak var serviceWiFiButton: UIButton!
    
    var filter: Filter?
    var buttonList: [UIButton]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVaribles()
        setupUI()
    }
    
    private func initializeVaribles() {
        filter = Filter(chargeType: [], socketType: [], distanceKM: Int(distanceSliderValue.value), service: [])
        buttonList = [deviceTypeAcButton,
                      deviceTypeDcButton,
                      socketTypeTypeTwoButton,
                      socketTypeCscButton,
                      socketTypeChademoButton,
                      serviceCarParkButton,
                      serviceBuffetButton,
                      serviceWiFiButton]
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
        navigationBarItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0, weight: .medium)], for: .selected)
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // device type label color and font
        deviceTypeLabel.textColor = Theme.bodyTitleColor
        deviceTypeLabel.font = Theme.bodyTitleFont
        
        // add tint and border color to all filter options buttons
        addColorAndBorderToButtons(buttonList!)
        
        // socket type label color and font
        socketTypeLabel.textColor = Theme.bodyTitleColor
        socketTypeLabel.font = Theme.bodyTitleFont
        
        // device type label color and font
        distanceLabel.textColor = Theme.bodyTitleColor
        distanceLabel.font = Theme.bodyTitleFont
        
        // device type label color and font
        servicesLabel.textColor = Theme.bodyTitleColor
        servicesLabel.font = Theme.bodyTitleFont

    }
    
    private func addColorAndBorderToButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.tintColor = UIColor.clear
            button.layer.borderColor = UIColor.whiteColor.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = deviceTypeDcButton.frame.size.height * 0.5
        }
    }

    // reset filter
    @objc func resetFilter(_ sender: UIBarButtonItem) {
        
        // reset buttons color
        for button in buttonList! {
            button.tintColor = UIColor.clear
            button.layer.borderColor = UIColor.whiteColor.cgColor
        }
        
        // reset slider value to max
        distanceSliderValue.setValue(distanceSliderValue.maximumValue, animated: true)
        
        // reset filter object
        filter = Filter(chargeType: [], socketType: [], distanceKM: Int(distanceSliderValue.value), service: [])
    }
    
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
        
        // add filter option to filter's related property
        switch sender {
        case deviceTypeAcButton:
            sender.tintColor == UIColor.darkColor ? filter?.chargeType.append(ChargeType.ac) : filter?.chargeType.removeAll(where: { $0 == ChargeType.ac})
        case deviceTypeDcButton:
            sender.tintColor == UIColor.darkColor ? filter?.chargeType.append(ChargeType.dc) : filter?.chargeType.removeAll(where: { $0 == ChargeType.dc})
        case socketTypeTypeTwoButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType.append(SocketType.type2) : filter?.socketType.removeAll(where: { $0 == SocketType.type2})
        case socketTypeCscButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType.append(SocketType.csc) : filter?.socketType.removeAll(where: { $0 == SocketType.csc})
        case socketTypeChademoButton:
            sender.tintColor == UIColor.darkColor ? filter?.socketType.append(SocketType.chademo) : filter?.socketType.removeAll(where: { $0 == SocketType.chademo})
        case serviceCarParkButton:
            sender.tintColor == UIColor.darkColor ? filter?.service.append(Service.carPark) : filter?.service.removeAll(where: { $0 == Service.carPark})
        case serviceBuffetButton:
            sender.tintColor == UIColor.darkColor ? filter?.service.append(Service.buffet) : filter?.service.removeAll(where: { $0 == Service.buffet})
        case serviceWiFiButton:
            sender.tintColor == UIColor.darkColor ? filter?.service.append(Service.wifi) : filter?.service.removeAll(where: { $0 == Service.wifi})
        default:
            break
        }
    }
    
    // get value from slider and assign it filter's distanceKM property
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        filter?.distanceKM = value
    }
    
}
