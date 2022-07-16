//
//  CitySelectionViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import UIKit

class CitySelectionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var upperBodyView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityListView: UIView!
    @IBOutlet weak var noCityView: UIView!
    
    let viewModel = CitySelectionViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        setupUI()
        getCityList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCityList()
    }
    
    private func setupUI(){
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addApparance()
        
        // back button color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // add only bottom border to upperbodyview
        let thickness: CGFloat = 1.5
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.upperBodyView.frame.size.height - thickness, width: self.upperBodyView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.charcoalGrey.cgColor
        upperBodyView.layer.addSublayer(bottomBorder)
        
        // search bar
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"Şehir Ara", attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
        searchBar.layer.cornerRadius = 22.5
        searchBar.clipsToBounds = true
        searchBar.layer.borderColor = UIColor.greyScaleColor.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.backgroundImage = UIImage.imageWithColor(color: UIColor.darkColor)
        searchBar.searchTextField.backgroundColor = Theme.searchTextFieldBgColor
        searchBar.searchTextField.leftView?.tintColor = UIColor.whiteColor
        searchBar.searchTextField.textColor = UIColor.whiteColor
        
        // set views alphas zero
        noCityView.alpha = 0
        cityListView.alpha = 0
    }
    
    // call for getting city list
    private func getCityList() {
        Task.init{
            await viewModel.getCityList()
        }
    }
    
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

extension CitySelectionViewController: CitySelectionViewModelDelegate {
    
    func didCityListFetched(data: [String]) {
        
        DispatchQueue.main.async {
            self.cityListView.alpha = 1
            self.noCityView.alpha = 0
        }
    }
}
