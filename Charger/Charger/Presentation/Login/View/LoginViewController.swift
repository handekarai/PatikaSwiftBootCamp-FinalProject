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
        setupUI()
    }
    
    private func setupUI(){
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey

        //navigation bar appearance to avoid different appearance which comes with ios15
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.charcoalGrey
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        //welcome label
        let firstWordAttirubute = [NSAttributedString.Key.font: Theme.bodyTitleFont]
        let restOfSentenceAttirubute = [NSAttributedString.Key.font: Theme.bodyTitleThinFont]
        let firstWord = NSMutableAttributedString(string: "Charger'a ", attributes: firstWordAttirubute)
        let restOfSentence = NSAttributedString(string: "hoş geldiniz. ", attributes: restOfSentenceAttirubute)
        firstWord.append(restOfSentence)
        welcomeLabel.attributedText = firstWord
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
