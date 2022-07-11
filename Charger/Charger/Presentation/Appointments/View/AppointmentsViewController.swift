//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class AppointmentsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var makeAppointment: UIButton!
    @IBOutlet weak var noAppointmentView: UIView!
    @IBOutlet weak var appointmentListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    private func setupUI(){
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.charcoalGrey
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        navigationBar.standardAppearance = appearance;
        if #available(iOS 15.0, *) { // For compatibility with earlier iOS.
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
        // profile button in navigation bar
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Users"), style: .done, target: navigationBarItem, action: nil)
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // make an appointment button
        makeAppointment.tintColor = Theme.lightButtonBgColor
        noAppointmentView.alpha = 0.0
    }

    @IBAction func makeAppointmentTapped(_ sender: Any) {
    }
}

