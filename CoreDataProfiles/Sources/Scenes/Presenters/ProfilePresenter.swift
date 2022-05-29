//
//  ProfilePresenter.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: ProfilePresenterDelegate?
    var profile: NSManagedObject?
    var dataProvider = DataProvider()
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: ProfilePresenterDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func updateProfile() {
        
    }
}
