//
//  PickerView.swift
//  Charger
//
//  Created by Hande Kara on 7/27/22.
//

import UIKit

protocol PickerViewDelegate: AnyObject {
    func didDateSelected(date : Date)
}

class PickerView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: PickerViewDelegate?

     
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
        
        
        datePicker.backgroundColor = UIColor.darkColor
        datePicker.tintColor = UIColor.whiteColor
        
        addSubview(view)
    }

    func loadXib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Picker", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first as? UIView

        return view!
    }

    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        self.delegate?.didDateSelected(date: sender.date)
    }
    @IBAction func viewOutsidePickerTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
