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
    
    var cityList: [String] = []                     // list coming from api
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        setupUI()
        getCityList()
        addNotificationCenterObserver()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCityList()
    }
    
    // adds observers to notification center to observe filtering mechanism
    private func addNotificationCenterObserver () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilteredListNotification(_:)), name: NSNotification.Name(rawValue: "FilteredListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoFilterNotification(_:)), name: NSNotification.Name(rawValue: "NoFilterNotification"), object: nil)
    }
    
    // call for getting city list
    private func getCityList() {
        Task.init{
            await viewModel.getCityList()
        }
    }
    
    private func setupUI(){
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // add only bottom border to upperbodyview, it will be under search bar
        let thickness: CGFloat = 1.5
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.upperBodyView.frame.size.height - thickness, width: self.upperBodyView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.charcoalGrey.cgColor
        upperBodyView.layer.addSublayer(bottomBorder)
        
        // set search bar properties
        searchBar.delegate = self
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
    
    //MARK: - Objc functions
    // change search bar border color and view's visibility acccording to city list data
    @objc func handleFilteredListNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let list = dict["filteredList"] as? [String] {
                if list.isEmpty {
                    self.cityListView.alpha = 0
                    self.noCityView.alpha = 1
                    self.searchBar.layer.borderColor = UIColor.securityOnColor.cgColor
                }else {
                    self.cityListView.alpha = 1
                    self.noCityView.alpha = 0
                    self.searchBar.layer.borderColor = UIColor.primaryColor.cgColor
                }
            }
        }
    }
    
    // change view to initial state
    @objc func handleNoFilterNotification(_ notification: NSNotification) {
        self.cityListView.alpha = 1
        self.noCityView.alpha = 0
        self.searchBar.layer.borderColor = UIColor.greyScaleColor.cgColor
    }
    
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CitySelectionViewModelDelegate funcs
extension CitySelectionViewController: CitySelectionViewModelDelegate {
    
    // hides no city view, shows city list view
    func didCityListFetched(data: [String]) {
        // that delegation func triggered by background thread, but UI elements must be change at main thread, for that reason DispatchQueue.main.async  added
        DispatchQueue.main.async {
            self.cityList = data
            self.cityListView.alpha = 1
            self.noCityView.alpha = 0
        }
    }
}

// MARK: - UISearchBarDelegate funcs
extension CitySelectionViewController: UISearchBarDelegate {
    
    // triggered when user writes something to search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // if clear(X) button is pressed , do not need filter 
        if searchText.isEmpty{
            viewModel.noFilter()
        }else{
            viewModel.filterCityList(searchedText: searchText, cityList: self.cityList)
        }
    }
}
