//
//  AppointmentListViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import UIKit

class AppointmentListViewController: UIViewController {
    

    let scientists: [String] = ["Ali Kuşçu",
                                    "Aziz Sancar",
                                    "Cahit Arf"]
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight2: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view./
        tableview1.delegate = self
        tableview1.dataSource = self
        tableview2.delegate = self
        tableview2.dataSource = self
        registerCell()

   //     scroll.delegate = self
     //   scroll.bounces = false
//        tableview1.bounces = true
//        tableview1.isScrollEnabled = false
//        tableview2.bounces = true
//        tableview2.isScrollEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableview1.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tableview2.addObserver(self, forKeyPath: "contentSize2", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableview1.removeObserver(self, forKeyPath: "contentSize")
        self.tableview2.removeObserver(self, forKeyPath: "contentSize2")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.tableViewHeight.constant =  newSize.width
                }
            }
        }
        if keyPath == "contentSize2"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newSize = newvalue as! CGSize
                    self.tableViewHeight2.constant =  newSize.width
                }
            }
        }

    }
    
//    @IBOutlet weak var tableview2: UITableView!
    private func registerCell(){
        tableview1.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
        tableview2.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
extension AppointmentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.scientists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        cell.miniImageView.image = UIImage(named: "avatar")
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}

