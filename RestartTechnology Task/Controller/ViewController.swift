//
//  ViewController.swift
//  RestartTechnology Task
//
//  Created by Mohamed on 1/19/20.
//  Copyright © 2020 Mohamed74. All rights reserved.
//

import UIKit
import FanMenu

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bellManButton: UIButton!
    
    @IBOutlet weak var fanMenu: FanMenu!
    
    var heightOfHeader: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        setupFanMenu()
        
    }
    
    
    
    
    
    //MARK:- Fan Menu Setup
    
    func setupFanMenu(){
        
        
          fanMenu.isHidden = true
          // distance between button and items
          
          fanMenu.menuRadius = 100.0

          
         // animation duration
          fanMenu.duration = 0.35

          // menu background color
          fanMenu.menuBackground = .white


         fanMenu.button = FanMenuButton(
             id: "1",
             image: nil,
            color: .clear
         )

         fanMenu.items = [
             FanMenuButton(
                 id: "map",
                 image: "small_grey_location_pin",
                 color: .silver,
                 title: "Map",
                 titleColor: .black,
                 titlePosition: .bottom
            ),
            FanMenuButton(
                 id: "0",
                image: nil,
                 color: .clear
            ),
            FanMenuButton(
                id: "0",
                 image: nil,
                color: .clear
             ),
             FanMenuButton(
                id: "hotspot",
                image: "hotspot_icon",
                color: .silver,
                title: "HotSpots",
                 titleColor: .black,
                 titlePosition: .bottom
            ),FanMenuButton(
              id: "attarctions",
                 image: "attarctions_icon",
                 color: .silver,
                 title: "Attarctions",
                titleColor: .black,
                titlePosition: .bottom
             ),
              FanMenuButton(
                 id: "events",
                image: "events_icon",
                color: .silver,
                 title: "Events",
                titleColor: .black,
                 titlePosition: .bottom
           )
         ]
    
}

    
    //MARK:- IBAction
    
    @IBAction func bellClick(_ sender: Any) {
        if self.fanMenu.isOpen {
            self.fanMenu.isHidden = true
            self.fanMenu.close()
        }else {
            self.fanMenu.isHidden = false
            self.fanMenu.open()
        }
    }
}






//MARK:- TableView DataSource and Delegate Methods

extension ViewController: UITableViewDataSource , UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height / 3
    }
    
  
    
}
