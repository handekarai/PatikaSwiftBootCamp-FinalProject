//
//  AppointmentDetailViewController.swift
//  Charger
//
//  Created by Hande Kara on 8/3/22.
//

import UIKit

class AppointmentDetailViewController: UIViewController  {

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
    
    var notificationPickerView: NotificationTimePickerView!
    var popUp: PopUpView!
    
    let notificaonTimes = ["5 dakika önce", "10 dakika önce", "15 dakika önce", "30 dakika önce", "1 saat önce", "2 saat önce","3 saat önce"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notificationPicker popup
        self.notificationPickerView = NotificationTimePickerView(frame: self.view.frame)
        self.notificationPickerView.notificationPicker.delegate = self
        self.notificationPickerView.notificationPicker.dataSource = self

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
        notificationTimeButton.setTitle(notificaonTimes[0], for: .normal)
    }
    
    // prepares and show the notification time picker pop up
    private func showNotificationPicker(){
        self.view.addSubview(notificationPickerView)
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
    @IBAction func notificationTimeButtonTapped(_ sender: Any) {
        showNotificationPicker()
    }
}

extension AppointmentDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
     
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notificaonTimes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return notificaonTimes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        notificationTimeButton.setTitle(notificaonTimes[row], for: .normal)
    }
}
