//
//  AppointmentDetailViewController.swift
//  Charger
//
//  Created by Hande Kara on 8/3/22.
//

import UIKit

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stationCodeLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var socketNoLabel: UILabel!
    @IBOutlet weak var deviceTypeLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var notificationTimeButton: UIButton!
    
    var selectedStation: Station!
    var selectedSocket: SocketWithTime!
    var selectedTime: String!
    var selectedDate: String!
    var dateButtonText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI(){
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // navigation bar title
        navigationBarItem.titleView = UILabel.labelWithTitleAndSubtitle(title: "Randevu Detayı", subTitle: "\(selectedStation.stationName)")
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // set approveButton color
        approveButton.tintColor = Theme.lightButtonBgColor
        
        addressLabel.text = selectedStation.geoLocation.address
        distanceLabel.text = " \(Int(selectedStation.distanceInKM ?? 0)) km"
        stationCodeLabel.text = selectedStation.stationCode
        
        var services: String = ""
        for service in selectedStation.services {
            services = "\(services) \(service)"
        }
        servicesLabel.text = services
        socketNoLabel.text = "\(selectedSocket.socketNumber)"
        deviceTypeLabel.text = selectedSocket.chargeType
        socketTypeLabel.text = selectedSocket.socketType
        powerLabel.text = "\(selectedSocket.power) \(selectedSocket.powerUnit)"
        dateLabel.text = dateButtonText
        timeLabel.text = selectedTime
        
        notificationTimeButton.isHidden =  notificationSwitch.isOn ? false : true
    }
    
    //MARK: - objc funcs
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            notificationTimeButton.isHidden = false
        } else {
            notificationTimeButton.isHidden = true
        }
    }
}
