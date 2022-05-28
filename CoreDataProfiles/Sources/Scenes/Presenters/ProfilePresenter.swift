//
//  ProfilePresenter.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: ProfilePresenterDelegate?
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: ProfilePresenterDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Functions
}
