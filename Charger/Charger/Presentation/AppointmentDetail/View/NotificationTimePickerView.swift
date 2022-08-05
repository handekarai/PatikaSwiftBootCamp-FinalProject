//
//  NotificationTimePicker.swift
//  Charger
//
//  Created by Hande Kara on 8/6/22.
//

import UIKit


class NotificationTimePickerView: UIView {

    @IBOutlet weak var notificationPicker: UIPickerView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x:0, y:0,width: frame.width,height: frame.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        
        self.notificationPicker.backgroundColor = UIColor.darkColor
        self.notificationPicker.tintColor = UIColor.whiteColor
        
        addSubview(view)
    }

    func loadXib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NotificationTimePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first as? UIView

        return view!
    }
    
    @IBAction func outsideOfPickerTapped(_ sender: Any) {
        self.removeFromSuperview()
    }

}
