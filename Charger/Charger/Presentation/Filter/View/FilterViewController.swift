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
    @IBOutlet weak var filterButton: UIButton!
    
    var filter: Filter = Filter(chargeType: [], socketType: [], distanceKM: 15, service: [])
    var buttonList: [UIButton]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVaribles()
        setupUI()
    }
    
    private func initializeVaribles() {
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
        
        // filter button
        filterButton.tintColor = Theme.lightButtonBgColor
    }
    
    private func addColorAndBorderToButtons(_ buttons: [UIButton]) {
        
        for button in buttons {
            button.tintColor = UIColor.clear
            button.layer.borderColor = UIColor.whiteColor.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = deviceTypeDcButton.frame.size.height * 0.5
        }
        
        if !(filter.chargeType.isEmpty && filter.socketType.isEmpty && filter.service.isEmpty && filter.distanceKM == 15) {
        for type in filter.chargeType {
            switch type{
            case ChargeType.ac.rawValue:
                deviceTypeAcButton.tintColor = UIColor.darkColor
                deviceTypeAcButton.layer.borderColor = UIColor.primaryColor.cgColor
            case ChargeType.dc.rawValue:
                deviceTypeDcButton.tintColor = UIColor.darkColor
                deviceTypeDcButton.layer.borderColor = UIColor.primaryColor.cgColor
            default:
                print("")
            }
        }
        
            for type in filter.socketType {
            switch type{
            case SocketType.type2.rawValue:
                socketTypeTypeTwoButton.tintColor = UIColor.darkColor
                socketTypeTypeTwoButton.layer.borderColor = UIColor.primaryColor.cgColor
            case SocketType.csc.rawValue:
                socketTypeCscButton.tintColor = UIColor.darkColor
                socketTypeCscButton.layer.borderColor = UIColor.primaryColor.cgColor
            case SocketType.chademo.rawValue:
                socketTypeChademoButton.tintColor = UIColor.darkColor
                socketTypeChademoButton.layer.borderColor = UIColor.primaryColor.cgColor
            default:
                print("")
            }
        }
        
            for type in filter.service {
            switch type{
            case Service.carPark.rawValue:
                serviceCarParkButton.tintColor = UIColor.darkColor
                serviceCarParkButton.layer.borderColor = UIColor.primaryColor.cgColor
            case Service.wifi.rawValue:
                serviceWiFiButton.tintColor = UIColor.darkColor
                serviceWiFiButton.layer.borderColor = UIColor.primaryColor.cgColor
            case Service.buffet.rawValue:
                serviceBuffetButton.tintColor = UIColor.darkColor
                serviceBuffetButton.layer.borderColor = UIColor.primaryColor.cgColor
            default:
                print("")
            }
        }
        
    
        distanceSliderValue.setValue(Float(filter.distanceKM), animated: true)
        
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
            sender.tintColor == UIColor.darkColor ? filter.chargeType.append(ChargeType.ac.rawValue) : filter.chargeType.removeAll(where: { $0 == ChargeType.ac.rawValue})
        case deviceTypeDcButton:
            sender.tintColor == UIColor.darkColor ? filter.chargeType.append(ChargeType.dc.rawValue) : filter.chargeType.removeAll(where: { $0 == ChargeType.dc.rawValue})
        case socketTypeTypeTwoButton:
            sender.tintColor == UIColor.darkColor ? filter.socketType.append(SocketType.type2.rawValue) : filter.socketType.removeAll(where: { $0 == SocketType.type2.rawValue})
        case socketTypeCscButton:
            sender.tintColor == UIColor.darkColor ? filter.socketType.append(SocketType.csc.rawValue) : filter.socketType.removeAll(where: { $0 == SocketType.csc.rawValue})
        case socketTypeChademoButton:
            sender.tintColor == UIColor.darkColor ? filter.socketType.append(SocketType.chademo.rawValue) : filter.socketType.removeAll(where: { $0 == SocketType.chademo.rawValue})
        case serviceCarParkButton:
            sender.tintColor == UIColor.darkColor ? filter.service.append(Service.carPark.rawValue) : filter.service.removeAll(where: { $0 == Service.carPark.rawValue})
        case serviceBuffetButton:
            sender.tintColor == UIColor.darkColor ? filter.service.append(Service.buffet.rawValue) : filter.service.removeAll(where: { $0 == Service.buffet.rawValue})
        case serviceWiFiButton:
            sender.tintColor == UIColor.darkColor ? filter.service.append(Service.wifi.rawValue) : filter.service.removeAll(where: { $0 == Service.wifi.rawValue})
        default:
            break
        }
    }
    
    // filters the station list and go back to station selection screen
    @IBAction func filterButtonTapped(_ sender: Any) {
        let notificationDict = ["filter": filter]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterOptionsNotification"), object: nil, userInfo: notificationDict)
        navigationController?.popViewController(animated: true)
    }
    
    // get value from slider and assign it filter's distanceKM property
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        filter.distanceKM = value
    }
    
}
