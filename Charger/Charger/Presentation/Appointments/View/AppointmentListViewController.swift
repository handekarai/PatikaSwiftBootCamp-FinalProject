//
//  AppointmentListViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class AppointmentListViewController: UIViewController, AppointmentsViewModelDelegate {

    private var currentAppointmentsList: [Appointment] = []
    private var passedAppointmentsList: [Appointment] = []
    
    @IBOutlet weak var currentAppointmentsLabel: UILabel!
    @IBOutlet weak var passedAppointmentsLabel: UILabel!
    @IBOutlet weak var currentAppointmentsTableView: UITableView!
    @IBOutlet weak var passedAppointmentsTableView: UITableView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight2: NSLayoutConstraint!
    
    let viewModel = AppointmentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupUI()
        registerCell()

//        scroll.delegate = self
//        scroll.bounces = false
//        currentAppointmentsTableView.bounces = true
//        currentAppointmentsTableView.isScrollEnabled = false
//        passedAppointmentsTableView.bounces = true
//        passedAppointmentsTableView.isScrollEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.currentAppointmentsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.passedAppointmentsTableView.addObserver(self, forKeyPath: "contentSize2", options: .new, context: nil)
        
        currentAppointmentsLabel.isHidden = true
        passedAppointmentsLabel.isHidden = true
        
        currentAppointmentsTableView.isHidden = true
        passedAppointmentsTableView.isHidden = true
        
        Task.init{
            await viewModel.getAppointments()
        }
        self.passedAppointmentsTableView.reloadData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.currentAppointmentsTableView.removeObserver(self, forKeyPath: "contentSize")
        self.passedAppointmentsTableView.removeObserver(self, forKeyPath: "contentSize2")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.tableViewHeight.constant =  newSize.width
                }
            }
        }
        if keyPath == "contentSize2"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.tableViewHeight2.constant =  newSize.width
                }
            }
        }

    }
    
    private func setupUI(){
        
        currentAppointmentsTableView.delegate = self
        currentAppointmentsTableView.dataSource = self
        
        passedAppointmentsTableView.delegate = self
        passedAppointmentsTableView.dataSource = self
        
    }
    
    private func registerCell(){
        currentAppointmentsTableView.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
        passedAppointmentsTableView.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
    }

    func passedAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.passedAppointmentsList = data
            self.passedAppointmentsLabel.isHidden = false
            self.passedAppointmentsTableView.isHidden = false
            self.passedAppointmentsTableView.reloadData()
        }
    }
    
    func currentAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.currentAppointmentsList = data
            self.currentAppointmentsLabel.isHidden = false
            self.currentAppointmentsTableView.isHidden = false
            self.currentAppointmentsTableView.reloadData()
        }
    }
    
    func noAppointments() {
        DispatchQueue.main.async {
            self.currentAppointmentsLabel.isHidden = true
            self.passedAppointmentsLabel.isHidden = true
            self.currentAppointmentsTableView.isHidden = true
            self.passedAppointmentsTableView.isHidden = true
        }
    }

}
// table view delegation
extension AppointmentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView{
        case currentAppointmentsTableView:
            return currentAppointmentsList.count
        case passedAppointmentsTableView:
            return passedAppointmentsList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell

        switch tableView{
        case currentAppointmentsTableView:
            
            cell.miniImageView.image = UIImage(named: viewModel.getImage(currentAppointmentsList[indexPath.section]))
            cell.titleLabel.text = currentAppointmentsList[indexPath.section].stationName
            cell.deleteButton.isHidden = false

            cell.dateLabel.text = viewModel.formatDate(currentAppointmentsList[indexPath.section].date) + ", " + currentAppointmentsList[indexPath.section].time
            cell.alarmLabel.text = currentAppointmentsList[indexPath.section].time
            cell.socketNumberLabel.text = "Soket Numarası: \(currentAppointmentsList[indexPath.section].socketID)"
            cell.socketTypeLabel.text = viewModel.getSocketAndChargeType(currentAppointmentsList[indexPath.section])
            return cell
        case passedAppointmentsTableView:
            
            cell.miniImageView.image = UIImage(named: viewModel.getImage(passedAppointmentsList[indexPath.section]))
            cell.titleLabel.text = passedAppointmentsList[indexPath.section].stationName
            cell.deleteButton.isHidden = true

            cell.dateLabel.text = viewModel.formatDate(passedAppointmentsList[indexPath.section].date) + ", " + passedAppointmentsList[indexPath.section].time
            cell.alarmLabel.text = passedAppointmentsList[indexPath.section].time
            cell.socketNumberLabel.text = "Soket Numarası: \(passedAppointmentsList[indexPath.section].socketID)"
            cell.socketTypeLabel.text = viewModel.getSocketAndChargeType(passedAppointmentsList[indexPath.section])

        default:
            print("something wrong")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}

