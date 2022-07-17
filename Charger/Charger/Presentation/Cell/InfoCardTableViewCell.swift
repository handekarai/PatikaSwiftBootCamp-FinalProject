//
//  InfoCardTableViewCell.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class InfoCardTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var firstSubInfoStack: UIStackView!
    @IBOutlet weak var firstSubInfoStackLeadingLabel: UILabel!
    @IBOutlet weak var firstSubInfoStackTrailingLabel: UILabel!
    @IBOutlet weak var secondSubInfoStack: UIStackView!
    @IBOutlet weak var secondSubInfoStackLeadingLabel: UILabel!
    @IBOutlet weak var secondSubInfoStackTrailingLabel: UILabel!
    @IBOutlet weak var miniImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // make corners smooth
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        self.firstSubInfoStack.layer.cornerRadius = 5
        self.firstSubInfoStack.clipsToBounds = true
        
        self.secondSubInfoStack.layer.cornerRadius = 5
        self.secondSubInfoStack.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
