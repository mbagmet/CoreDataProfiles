//
//  ProfileViewController.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import UIKit

// MARK: - View
class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter = ProfilePresenter()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(delegate: self)

        setupView()
        print(presenter.profile)
    }
    
    // MARK: - Settings
    
    private func setupView() {
        view.backgroundColor = .tertiarySystemBackground | .systemBackground
    }
}

// MARK: - Presenter Delegate
extension ProfileViewController: ProfilePresenterDelegate {
    
}
