//
//  DetailController.swift
//  Resume
//
//  Created by specktro on 5/21/19.
//  Copyright © 2019 specktro. All rights reserved.
//

import UIKit

// MARK: - DetailController class
final class DetailController: UIViewController {
    public var section: Section?
    
    // MARK: - Attributes
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    deinit {
        debugPrint(">>> deinit \(String(describing: self))")
    }
    
    // MARK: - Private methods
    func customize() {
        self.title = section?.title
        self.summaryLabel.text = section?.summary
    }
}
