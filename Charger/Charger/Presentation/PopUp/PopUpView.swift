//
//  PopUpView.swift
//  Charger
//
//  Created by Hande Kara on 7/7/22.
//

import UIKit

class PopUpView: UIView {


    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstOptionButton: UIButton!
    @IBOutlet weak var secondOptionButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x:0, y:0,width: frame.width,height: frame.height))
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        
        //label texts properties
        titleLabel.font = Theme.popUpTitleFont
        titleLabel.textColor = Theme.popUpTitleColor
        descriptionLabel.font = Theme.popUpSubTitleFont
        descriptionLabel.textColor = Theme.popUpSubTitleColor
        
        // second option button border
        secondOptionButton.layer.borderColor = UIColor.greyScaleColor.cgColor
        secondOptionButton.layer.borderWidth = 0.5
        secondOptionButton.layer.cornerRadius = secondOptionButton.frame.size.height * 0.5
        // make popop corner more smooth
        popUp.layer.cornerRadius = 10
        addSubview(view)
    }
    
    
    func loadXib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first as? UIView

        return view!
    }
    
}
