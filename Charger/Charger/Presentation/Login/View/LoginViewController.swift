//
//  SplashViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/5/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bodyView: UIView!
    
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }
     
    required init?(coder: NSCoder) {
        viewModel = LoginViewModel()
        viewModel.requestPermission()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.charcoalGrey

        //nav bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.charcoalGrey
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        //welcome label
        let firstWordAttirubute = [NSAttributedString.Key.font: Theme.bodyTitleFont]
        let restOfSentenceAttirubute = [NSAttributedString.Key.font: Theme.bodyTitleThinFont]
        let firstString = NSMutableAttributedString(string: "Charger'a ", attributes: firstWordAttirubute)
        let secondString = NSAttributedString(string: "hoş geldiniz. ", attributes: restOfSentenceAttirubute)
        firstString.append(secondString)
        welcomeLabel.attributedText = firstString
        welcomeLabel.textColor = Theme.darkButtonTextColor
        
        //message label
        messageLabel.font = Theme.bodySubtitleFont
        messageLabel.textColor = Theme.darkButtonTextColor

        //login button
        loginButton.tintColor = Theme.lightButtonBgColor
        
        //body view gradient layer in background
        bodyView.addGradient()
        
        // text field
        let placeholder = emailTextField.placeholder ?? ""
        emailTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor :  UIColor.lightGray])
        emailTextField.addUnderLine()
        
    }
        
}

extension UIView{
    func addGradient () {
        let colorTop =  UIColor(red: 0.24, green: 0.26, blue: 0.31, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.08, green: 0.09, blue: 0.12, alpha: 1.00).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}


extension UITextField {
    
    func addUnderLine () {
        let bottomLine = CALayer()
        // underline properties
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height, width: self.bounds.width - 18, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
