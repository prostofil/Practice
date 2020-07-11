//
//  MainViewController.swift
//  BasicWeatherApp
//
//  Created by Fedosov Sergey on 10.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var ccities = ["a","s","s","f","f","d"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ccities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = ccities[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        
        let name = ccities[indexPath.row]
        detailsVC.text = name
        navigationController?.pushViewController(detailsVC, animated: true)
    }
   
    

}
