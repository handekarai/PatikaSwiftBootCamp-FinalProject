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
    
    var selectedStation: Station!
    var picker: PickerView!
    var popUp: PopUpView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
