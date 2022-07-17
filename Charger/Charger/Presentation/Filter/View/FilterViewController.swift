//
//  FilterViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bodyBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // filter image has not given in assets for that reason i put "line.horizontal.3.decrease" image, it looks like filter image
        navigationBarItem.rightBarButtonItem = UIBarButtonItem(title: "TEMİZLE", style: .done, target: self, action: #selector(resetFilter(_:)))
        navigationBarItem.rightBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
    }

    // reset filter
    @objc func resetFilter(_ sender: UIBarButtonItem) {}
    
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
