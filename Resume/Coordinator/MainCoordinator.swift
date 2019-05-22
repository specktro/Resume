//
//  MainCoordinator.swift
//  Resume
//
//  Created by specktro on 5/21/19.
//  Copyright © 2019 specktro. All rights reserved.
//

import UIKit

// MARK: - MainCoordinator class
/// This class will control all the application flows inside de application
final class MainCoordinator {
    // MARK: - Attributes
    public weak var window: UIWindow?
    fileprivate weak var profileControler: ProfileController?
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        
        self.initialFlow()
    }
    
    // MARK: - Private methods
    func initialFlow() {
        let mainBoard = UIStoryboard(name: StoryBoard.main.rawValue, bundle: nil)
        let profileController = mainBoard.instantiateViewController(withIdentifier: ControllerIdentifier.profile.rawValue) as? ProfileController
        profileController?.refresh = self.refresh
        profileController?.select = self.select
        self.window?.rootViewController = UINavigationController(rootViewController: profileController!)
        self.profileControler = profileController
    }
}

// MARK: - Profile application flow
extension MainCoordinator {
    func refresh(profile: Profile) {
        debugPrint("This is the default refresh callback implementation")
    }
    
    func select(section: Section) {
        debugPrint("This is the default select callback implementation, the \(section.title) was choosen")
    }
}
