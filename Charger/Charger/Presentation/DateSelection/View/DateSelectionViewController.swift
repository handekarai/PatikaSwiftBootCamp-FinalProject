//
//  DateSelectionViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/26/22.
//

import UIKit

class DateSelectionViewController: UIViewController, PickerViewDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var approveDateAndTimeButton: UIButton!
    @IBOutlet weak var socketsNameStackView: UIStackView!
    @IBOutlet weak var socketsSlotsStackView: UIStackView!
    @IBOutlet weak var firstSocketTableView: UITableView!
    @IBOutlet weak var secondSocketTableView: UITableView!
    @IBOutlet weak var thirdSocketTableView: UITableView!
    
    var selectedStation: Station!
    var picker: PickerView!
    var popUp: PopUpView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstSocketTableView.delegate = self
        self.secondSocketTableView.delegate = self
        self.thirdSocketTableView.delegate = self

        self.firstSocketTableView.dataSource = self
        self.secondSocketTableView.dataSource = self
        self.thirdSocketTableView.dataSource = self
        firstSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")
        secondSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")
        thirdSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")

        
        self.picker = PickerView(frame: self.view.frame)
        self.picker.delegate = self
        setupUI()
    }
    
    // prepares and show the picker pop up
    private func showPicker(){
        self.view.addSubview(picker)
    }
    
    // prepares and show the pop up
    private func showPopUp(){
        self.popUp = PopUpView(frame: self.view.frame)
        self.popUp.titleLabel.text = "Geçersiz Tarih"
        self.popUp.descriptionLabel.text = "Geçmiş bir tarihe randevu alamazsınız."
        self.popUp.firstOptionButton.addTarget(self, action: #selector(reSelectButtonTapped), for: .touchUpInside)
        self.popUp.firstOptionButton.setTitle("DÜZENLE", for: .normal)
        self.popUp.secondOptionButton.addTarget(self, action: #selector(choseTodayButtonTapped), for: .touchUpInside)
        self.popUp.secondOptionButton.setTitle("BUGÜNÜ SEÇ", for: .normal)

        self.view.addSubview(popUp)
    }
    
    private func prepareAndShowSocketView(){
        var count = 1
        for socket in selectedStation.sockets {

            let label = UILabel.labelWithTitleAndSubtitle(title: "Soket \(count)", subTitle: "\(socket.chargeType ?? "null") · \(socket.socketType ?? "null")")!
            label.textAlignment = .center
            socketsNameStackView.addArrangedSubview(label)
            count += 1
        }
        
        // according to socket count show or hide table views
        switch count{
        case 1:
            firstSocketTableView.isHidden = true
            secondSocketTableView.isHidden = true
            thirdSocketTableView.isHidden = true
        case 2:
            firstSocketTableView.isHidden = false
            secondSocketTableView.isHidden = true
            thirdSocketTableView.isHidden = true
        case 3:
            firstSocketTableView.isHidden = false
            secondSocketTableView.isHidden = false
            thirdSocketTableView.isHidden = true
        case 4:
            firstSocketTableView.isHidden = false
            secondSocketTableView.isHidden = false
            thirdSocketTableView.isHidden = false
        default:
            break
        }
    }
    
    private func setupUI () {
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // navigation bar title
        navigationBarItem.titleView = UILabel.labelWithTitleAndSubtitle(title: "Tarih ve Saat Seçin", subTitle: "\(selectedStation.stationName)")
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // add color and font to appointment date label
        appointmentDateLabel.textColor = Theme.bodyHeadLineColor
        appointmentDateLabel.font = Theme.bodyHeadLineFont
        
        // set date button text
        dateButton.tintColor = Theme.bodyHeadLineColor
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none))
        dateButton.setTitle(date, for: .normal)
        
        // set approveDateAndTimeButton color
        approveDateAndTimeButton.tintColor = Theme.lightButtonBgColor
        
        // show socket view according to sockect count
        prepareAndShowSocketView()
    }
    
    //MARK: - objc funcs
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func choseTodayButtonTapped(_ sender: Any) {
        self.popUp.removeFromSuperview()
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none))
        dateButton.setTitle(date, for: .normal)
    }
    
    @objc func reSelectButtonTapped(_ sender: Any) {
        self.popUp.removeFromSuperview()
        showPicker()
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        showPicker()
    }
    
    
    func didDateSelected(date: Date) {
        // if date is passed than show popup
        if date < Date(){
            self.picker.removeFromSuperview()
            showPopUp()
        } else {
            let date = String(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))
            dateButton.setTitle(date, for: .normal)
        }
    }
}

let hours = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00"]


extension DateSelectionViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hours.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotCell", for: indexPath) as! TimeSlotTableViewCell
        cell.label.text = hours[indexPath.section]
        return cell
    }
    
    // for spaces beetwen cells in table view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
}
