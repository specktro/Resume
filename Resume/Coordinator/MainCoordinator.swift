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
    fileprivate lazy var profile: Profile? = {
        let name = "Miguel Angel Gómez Rivero"
        let nickname = "specktro"
        let summary = "An enthusiastic software developer"
        let tools = "xcode, swift, git, coordinators"
        let sections = [Section(title: "Experience", url: "", summary: "An old iOS developer, with more than nine years working with the apple ecosystem, the iOS SDK is his vocation. \n\nHe forgot the number of developed applications by himself and now he loves to teach all he knows to the new iOS generation."),
                        Section(title: "Academic", url: "", summary: "Specktro studied at ESCOM - IPN his computer science degree; since he was a child he experienced too much love about the maths and the money :v for that reason he became an engineer.")]
        return Profile(name: name, nickname: nickname, summary: summary, tools: tools, sections: sections)
    }()
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        
        self.initialFlow()
    }
    
    // MARK: - Private methods
    private func initialFlow() {
        let mainBoard = UIStoryboard(name: StoryBoard.main.rawValue, bundle: nil)
        let profileController = mainBoard.instantiateViewController(withIdentifier: ControllerIdentifier.profile.rawValue) as? ProfileController
        profileController?.profile = self.profile
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
        let mainBoard = UIStoryboard(name: StoryBoard.main.rawValue, bundle: nil)
        let detailController = mainBoard.instantiateViewController(withIdentifier: ControllerIdentifier.detail.rawValue) as? DetailController
        detailController?.section = section
        self.profileControler?.navigationController?.pushViewController(detailController!, animated: true)
    }
}
