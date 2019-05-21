//
//  ViewController.swift
//  Resume
//
//  Created by specktro on 5/21/19.
//  Copyright © 2019 specktro. All rights reserved.
//

import UIKit

// MARK: - ProfileController class
class ProfileController: UITableViewController {
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customize()
    }
    
    deinit {
        debugPrint(">>> deinit \(String(describing: self))")
    }
    
    // MARK: - Private methods
    private func customize() {
        self.title = NSLocalizedString("SPCK Resume", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.profile.rawValue)
    }
    
    // MARK: - Table view stuff
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.profile.rawValue, for: indexPath)
        cell.textLabel?.text = "cell \(indexPath.row + 1)"
        return cell
    }
}

