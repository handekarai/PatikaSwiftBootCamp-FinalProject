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
    
    let viewModel = DateSelectionViewModel()
    
    var selectedStation: Station!
    var picker: PickerView!
    var popUp: PopUpView!
    
    var socketOneTimeSlots: [TimeSlot]?
    var socketTwoTimeSlots: [TimeSlot]?
    var socketThreeTimeSlots: [TimeSlot]?
    
    var selectedRowInFirstTableView: IndexPath?
    var selectedRowInSecondTableView: IndexPath?
    var selectedRowInThirdTableView: IndexPath?
    
    var selectedTime: String?
    var selectedDate: String?
    var dateButtonText: String?
    var selectedSocket: SocketWithTime?
    var sockets: [SocketWithTime]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstSocketTableView.delegate = self
        self.secondSocketTableView.delegate = self
        self.thirdSocketTableView.delegate = self

        self.firstSocketTableView.dataSource = self
        self.secondSocketTableView.dataSource = self
        self.thirdSocketTableView.dataSource = self
        
        // register cell for three table views
        firstSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")
        secondSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")
        thirdSocketTableView.register(UINib(nibName: "TimeSlot", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")

        // picker popup
        self.picker = PickerView(frame: self.view.frame)
        self.picker.delegate = self
        
        setupUI()
        
        // get station occupancy for current date
        getOccupancy(for: Date())

    }
    
    //MARK: - private funcs
    // gets occupancy situation of station for specific date
    private func getOccupancy(for date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = dateFormatter.string(from: date)
        selectedDate = resultString
        Task.init{
            await viewModel.getStationOccupancy(stationID: selectedStation.id, date: resultString)
        }
    }
    
    // hide or show socket views
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
        
        viewModel.delegate = self
        
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
    
    @IBAction func approveDateAndTimeButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailViewController") as? AppointmentDetailViewController{
            vc.selectedStation = selectedStation
            vc.selectedSocket = selectedSocket
            vc.selectedTime = selectedTime
            vc.selectedDate = selectedDate
            vc.dateButtonText = dateButton.titleLabel?.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    
    func didDateSelected(date: Date) {
        // if date is passed than show popup
        if date < Date(){
            self.picker.removeFromSuperview()
            showPopUp()
        } else {
            // get time slots data for chosen date
            Task.init{
                getOccupancy(for: date)
            }
            let date = String(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))
            dateButton.setTitle(date, for: .normal)
        }
    }
}

//MARK: - UITableViewDelegate funcs
extension DateSelectionViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView{
        case firstSocketTableView:
            return socketOneTimeSlots?.count ?? 0
        case secondSocketTableView:
            return socketTwoTimeSlots?.count ?? 0
        case thirdSocketTableView:
            return socketThreeTimeSlots?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotCell", for: indexPath) as! TimeSlotTableViewCell
        
        var listToBeUsed: [TimeSlot]
        
        switch tableView{
        case firstSocketTableView:
            listToBeUsed = socketOneTimeSlots!
        case secondSocketTableView:
            listToBeUsed = socketTwoTimeSlots!
        case thirdSocketTableView:
            listToBeUsed = socketThreeTimeSlots!
        default:
            listToBeUsed = []
        }
        
        if !listToBeUsed.isEmpty {
            cell.label.text = listToBeUsed[indexPath.section].slot
            
            // if time slot is occupied by someone else, then do not let user interaction
            if listToBeUsed[indexPath.section].isOccupied {
                cell.isUserInteractionEnabled = false
                cell.label.textColor = UIColor.whiteColor.withAlphaComponent(0.1)
            } else {
                cell.isUserInteractionEnabled = true
                cell.label.textColor = UIColor.whiteColor
            }
        }

        return cell
    }
    
    // for spaces beetwen cells in table view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // if one table views row selected deslected other table views rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView{
        case firstSocketTableView:
            selectedRowInFirstTableView = indexPath
            selectedTime = socketOneTimeSlots?[indexPath.section].slot
            selectedSocket = sockets?[0]

            if let lastSelected = selectedRowInSecondTableView {
                secondSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInSecondTableView = nil

            }
            if let lastSelected = selectedRowInThirdTableView {
                thirdSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInThirdTableView = nil
            }

        case secondSocketTableView:
            selectedRowInSecondTableView = indexPath
            selectedTime = socketTwoTimeSlots?[indexPath.section].slot
            selectedSocket = sockets?[1]

            if let lastSelected = selectedRowInFirstTableView {
                firstSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInFirstTableView = nil
            }
            if let lastSelected = selectedRowInThirdTableView {
                thirdSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInThirdTableView = nil

            }

        case thirdSocketTableView:
            selectedRowInThirdTableView = indexPath
            selectedTime = socketThreeTimeSlots?[indexPath.section].slot
            selectedSocket = sockets?[2]

            if let lastSelected = selectedRowInFirstTableView {
                firstSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInFirstTableView = nil
            }
            if let lastSelected = selectedRowInSecondTableView {
                secondSocketTableView.deselectRow(at: lastSelected, animated: true)
                selectedRowInSecondTableView = nil
            }

        default:
            break
        }
    }
    
    
}

//MARK: - DateSelectionViewModelDelegate funcs
extension DateSelectionViewController: DateSelectionViewModelDelegate {
    
    // reload table view according to data
    func didStationOccupancyDataFetched(data: StationTimeDetail) {
        sockets = data.sockets
        
        switch sockets?.count {
        case 1:
            socketOneTimeSlots = sockets?[0].day.timeSlots
        case 2:
            socketOneTimeSlots = sockets?[0].day.timeSlots
            socketTwoTimeSlots = sockets?[1].day.timeSlots

        case 3:
            socketOneTimeSlots = sockets?[0].day.timeSlots
            socketTwoTimeSlots = sockets?[1].day.timeSlots
            socketThreeTimeSlots = sockets?[2].day.timeSlots
        default:
            break
        }
        DispatchQueue.main.async {
            self.firstSocketTableView.reloadData()
            self.secondSocketTableView.reloadData()
            self.thirdSocketTableView.reloadData()
        }
    }
}
