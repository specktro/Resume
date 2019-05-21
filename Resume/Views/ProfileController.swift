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
    // MARK: - Attributes
    private lazy var profile: Profile? = {
        let name = "Miguel Angel Gómez Rivero"
        let nickname = "specktro"
        let summary = "An enthusiastic software developer"
        let tools = "xcode, swift, git, coordinators"
        let sections = [Section(title: "Experience", url: "", summary: nil), Section(title: "Academic", url: "", summary: nil)]
        return Profile(name: name, nickname: nickname, summary: summary, tools: tools, sections: sections)
    }()
    private var refresh: (Profile) -> () = { _ in
        debugPrint("This is the default refresh callback implementation")
    }
    private var select: (Section) -> () = { section in
        debugPrint("This is the default select callback implementation, the \(section.title) was choosen")
    }
    
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
        self.title = self.profile?.nickname
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.profile.rawValue)
    }
    
    // MARK: - Table view stuff
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profile?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.profile?.sections[indexPath.row] else {
            fatalError("There is not profile configured, yo need a profile to work")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.profile.rawValue, for: indexPath)
        cell.textLabel?.text = section.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = self.profile?.sections[indexPath.row] else {
            fatalError("There is not profile configured, yo need a profile to work")
        }
        
        self.select(section)
    }
}

