//
//  PopUpView.swift
//  Charger
//
//  Created by Hande Kara on 7/7/22.
//

import UIKit

class PopUpView: UIView {


    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        //label texts
        titleLabel.text = "Geçersiz E-posta Adresi"
        titleLabel.font = Theme.popUpTitleFont
        titleLabel.textColor = Theme.popUpTitleColor
        descriptionLabel.text = "Lütfen e-posta adresinizi doğru yazdığınızdan emin olunuz."
        descriptionLabel.font = Theme.popUpSubTitleFont
        descriptionLabel.textColor = Theme.popUpSubTitleColor
        
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
