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
    
    var popUp: PopUpView!
    
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
            
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //checks e mail is valid or not
        guard let isValid = emailTextField.text?.isValidEmail() else { return }
        
        if isValid{
            // login part
            // access app delegate to get uuid from it
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            Task.init{
            await viewModel.doLogin(emailTextField.text!, appDelegate.uuid ?? "")
                if let token = viewModel.token {
                    print(token)
                    goToAppointmentsScreen()
                }
            }
        }else{
            // show popup for wrong email
            self.popUp = PopUpView(frame: self.view.frame)
            self.popUp.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            self.view.addSubview(popUp)
        }
    }
    
    // closes the popup
    @objc func closeButtonTapped(){
        self.popUp.removeFromSuperview()
    }
    
    // opens appointment screen
    private func goToAppointmentsScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentsViewController") as? ViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
