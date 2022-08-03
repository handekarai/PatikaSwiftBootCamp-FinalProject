//
//  TimeSlotTableViewCell.swift
//  Charger
//
//  Created by Hande Kara on 8/1/22.
//

import UIKit

class TimeSlotTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // make corners smooth
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor.charcoalGrey
        self.label.textColor = UIColor.whiteColor
        
        // change UI when time slot selected
        let selectedView = UIView()
        selectedView.backgroundColor =  Theme.timeSlotBgColor
        selectedView.layer.borderColor = UIColor.primaryColor.cgColor
        selectedView.layer.borderWidth = 1
        selectedView.layer.cornerRadius = 5
        selectedView.clipsToBounds = true
        self.selectedBackgroundView = selectedView
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
