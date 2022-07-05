//
//  SplashViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/5/22.
//

import UIKit

class SplashViewController: UIViewController {

    var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }
     
    required init?(coder: NSCoder) {
        viewModel = SplashViewModel()
        viewModel.requestPermission()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hande")
    }
        
}
