//
//  DateSelectionViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/26/22.
//

import UIKit

class DateSelectionViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    
    var selectedStation: Station!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

}
