//
//  AppointmentTableViewCell.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var miniImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var socketNumberLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
    
}
