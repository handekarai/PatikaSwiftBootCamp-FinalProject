//
//  ProfileViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var profileCardView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        getData()
        setupUI()
    }
    
    // get user email and device id
    private func getData(){
        viewModel.getUserEmail()
        viewModel.getUserDeviceID()
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
        if #available(iOS 15.0, *) { // For compatibility with earlier iOS.
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
        // back button color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // profile card view make corners smooth and add shadow
        profileCardView.layer.cornerRadius = 5
        profileCardView.clipsToBounds = true
        profileCardView.layer.masksToBounds = false
        profileCardView.layer.shadowColor = UIColor.black.cgColor
        profileCardView.layer.shadowRadius = 4
        profileCardView.layer.shadowOpacity = 0.3
        profileCardView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)

        //logout button
        logoutButton.tintColor = Theme.lightButtonBgColor

    }
    
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

extension ProfileViewController: ProfileViewModelDelegate {
    
    func didUserEmailFecthed(data: String) {
        emailLabel.text = data
    }
    
    func didUserDeviceIDFecthed(data: String) {
        deviceIdLabel.text = data
    }
}
