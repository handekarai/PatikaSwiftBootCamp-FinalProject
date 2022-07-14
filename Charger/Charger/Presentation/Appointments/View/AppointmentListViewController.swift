//
//  AppointmentListViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit


class AppointmentListViewController: UIViewController {

    var currentAppointmentsList: [Appointment] = []
    var passedAppointmentsList: [Appointment] = []
    
    @IBOutlet weak var currentAppointmentsLabel: UILabel!
    @IBOutlet weak var passedAppointmentsLabel: UILabel!
    @IBOutlet weak var currentAppointmentsTableView: UITableView!
    @IBOutlet weak var passedAppointmentsTableView: UITableView!
    @IBOutlet weak var currentAppointmentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var passedAppointmentsTableViewHeight: NSLayoutConstraint!
    
    var popUp: PopUpView!
    
    let viewModel = AppointmentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        setupUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // for auto size table views height
        self.currentAppointmentsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.passedAppointmentsTableView.addObserver(self, forKeyPath: "contentSize2", options: .new, context: nil)
        
        currentAppointmentsLabel.isHidden = true
        passedAppointmentsLabel.isHidden = true
        
        currentAppointmentsTableView.isHidden = true
        passedAppointmentsTableView.isHidden = true
        
        Task.init{
            await viewModel.getAppointments()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // for auto size table views height
        self.currentAppointmentsTableView.removeObserver(self, forKeyPath: "contentSize")
        self.passedAppointmentsTableView.removeObserver(self, forKeyPath: "contentSize2")
    }
    
    // for auto size table views height
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.currentAppointmentsTableViewHeight.constant =  newSize.height
                }
            }
        }
        if keyPath == "contentSize2"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.passedAppointmentsTableViewHeight.constant =  newSize.height
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

}

// MARK: - TableView Delegation funcs
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell

        switch tableView{
            
        case currentAppointmentsTableView:
            
            // fill appointment cell for current ones
            cell.miniImageView.image = UIImage(named: viewModel.getImage(currentAppointmentsList[indexPath.section]))
            cell.titleLabel.text = currentAppointmentsList[indexPath.section].stationName
            cell.deleteButton.isHidden = false

            cell.dateLabel.text = viewModel.formatDate(currentAppointmentsList[indexPath.section].date,monthNameType: .short) + ", " + currentAppointmentsList[indexPath.section].time
            
            // if there is a permission than show that label
            if LoginViewModel.shared.isNotificationPermissionGiven{
                cell.alarmLabel.text =  currentAppointmentsList[indexPath.section].time
            }else{
                cell.alarmLabel.isHidden = true
            }
            cell.socketNumberLabel.text = "Soket Numarası: \(currentAppointmentsList[indexPath.section].socketID)"
            cell.socketTypeLabel.text = viewModel.getSocketAndChargeType(currentAppointmentsList[indexPath.section])
          
            cell.deleteButton.tag = indexPath.section
            cell.deleteButton.titleLabel?.tag = currentAppointmentsList[indexPath.section].appointmentID
            cell.deleteButton.addTarget(self, action:#selector(showPopup(_:)), for: .touchUpInside)
            
        case passedAppointmentsTableView:
            
            // fill appointment info for passed ones
            cell.miniImageView.image = UIImage(named: viewModel.getImage(passedAppointmentsList[indexPath.section]))
            cell.titleLabel.text = passedAppointmentsList[indexPath.section].stationName
            cell.deleteButton.isHidden = true

            cell.dateLabel.text = viewModel.formatDate(passedAppointmentsList[indexPath.section].date, monthNameType: .short) + ", " + passedAppointmentsList[indexPath.section].time
            cell.alarmLabel.text = viewModel.getPowerInfo(passedAppointmentsList[indexPath.section])
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
    
    // for auto sizing table views
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    // for auto sizing table views
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // for spaces beetwen cells in table view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    // MARK: - objc funcs
    @objc func showPopup(_ sender: UIButton) {
        
        // determine properties of pop up
        popUp = PopUpView(frame: self.view.frame)
        
        popUp.titleLabel.text = "Randevu İptali"
        popUp.descriptionLabel.text = "\(currentAppointmentsList[sender.tag].stationName) istasyonundaki " + viewModel.formatDate(currentAppointmentsList[sender.tag].date, monthNameType: .long) + " saat " + currentAppointmentsList[sender.tag].time + " randevunuz iptal edilecektir."
        
        // cancel appointment button, pass indexpath.section(sender.tag) and appointmentID(sender.titleLabel.tag) data with tags
        popUp.firstOptionButton.setTitle("RANDEVUYU İPTAL ET", for: .normal)
        popUp.firstOptionButton.tag = sender.tag
        popUp.firstOptionButton.titleLabel?.tag = sender.titleLabel!.tag
        popUp.firstOptionButton.addTarget(self, action: #selector(appointmentCancelButtonTapped), for: .touchUpInside)
        
        // close pop up button
        popUp.secondOptionButton.setTitle("VAZGEÇ", for: .normal)
        popUp.secondOptionButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.view.addSubview(popUp)
    }
    
    // cancels the appointment
    @objc func appointmentCancelButtonTapped(_ sender: UIButton){
        // cancel call for network layer
        Task.init{
            await viewModel.deleteAppointment(appointmentID: sender.titleLabel!.tag, sectionID: sender.tag)
        }
        self.popUp.removeFromSuperview()
    }
    
    // closes the popup
    @objc func closeButtonTapped(){
        self.popUp.removeFromSuperview()
    }

}

// MARK: - AppointmentsViewModelDelegate
extension AppointmentListViewController: AppointmentsViewModelDelegate{
    
    // shows passed appointments main title and table view at body of screen
    func passedAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.passedAppointmentsList = data
            self.passedAppointmentsLabel.isHidden = false
            self.passedAppointmentsTableView.isHidden = false
            self.passedAppointmentsTableView.reloadData()
        }
    }
    
    // shows current appointments main title and table view at body of screen
    func currentAppointments(data: [Appointment]) {
        DispatchQueue.main.async {
            self.currentAppointmentsList = data
            self.currentAppointmentsLabel.isHidden = false
            self.currentAppointmentsTableView.isHidden = false
            self.currentAppointmentsTableView.reloadData()
        }
    }
    
    // hides table views and main titles
    func noAppointments() {
        DispatchQueue.main.async {
            self.currentAppointmentsLabel.isHidden = true
            self.passedAppointmentsLabel.isHidden = true
            self.currentAppointmentsTableView.isHidden = true
            self.passedAppointmentsTableView.isHidden = true
        }
    }
    
    func didAppointmentDeleted(sectionID: Int) {
        // for UI
        DispatchQueue.main.async {
            // remove table cell from array and table view with animation
            self.currentAppointmentsList.remove(at:sectionID)
            self.currentAppointmentsTableView.deleteSections([sectionID], with: .automatic)

            // after delete appointment if there is no current appointment then no need to show these
            if self.currentAppointmentsList.isEmpty {
                self.currentAppointmentsLabel.isHidden = true
                self.currentAppointmentsTableView.isHidden = true
            }
        }
    }
}
