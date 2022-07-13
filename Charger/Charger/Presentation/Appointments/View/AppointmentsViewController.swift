//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class AppointmentsViewController: UIViewController,AppointmentsViewModelDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var makeAppointment: UIButton!
    @IBOutlet weak var noAppointmentView: UIView!
    @IBOutlet weak var appointmentListView: UIView!
    
    
    let viewModel = AppointmentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAppointments()
    }
    

    private func setupUI(){
        
        viewModel.delegate = self
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
        
        // body view initially empty, after data fetch body view appears
        noAppointmentView.alpha = 0
        appointmentListView.alpha = 0
        
        // make an appointment button
        makeAppointment.tintColor = Theme.lightButtonBgColor
        
    }
    
    private func getAppointments(){
        Task.init{
            await viewModel.getAppointments()
        }
    }
    
    func passedAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.noAppointmentView.alpha = 0
            self.appointmentListView.alpha = 1
        }
    }
    
    func currentAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.noAppointmentView.alpha = 0
            self.appointmentListView.alpha = 1
        }
    }
    
    func noAppointments() {
        DispatchQueue.main.async {
            self.noAppointmentView.alpha = 1
        }
    }
    
    func didAppointmentDeleted() {
        getAppointments()
    }

    @IBAction func makeAppointmentTapped(_ sender: Any) {

    }
}

