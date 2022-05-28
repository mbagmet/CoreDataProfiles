//
//  RootPresenter.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData

class RootPresenter: RootPresenterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: RootPresenterDelegate?
    var profiles: [NSManagedObject] = []
    var dataProvider = DataProvider()
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: RootPresenterDelegate) {
        self.delegate = delegate
    }
    
    func setupProfiles() {
        dataProvider.felchProfilesList()
        
        guard let profiles = dataProvider.profiles else { return }
        self.profiles = profiles
    }
    
    // MARK: - Functions
    
    func addProfile(name: String) {
        dataProvider.addProfile(name: name) {
            self.updateProfiles()
            self.delegate?.reloadData()
        }
    }
    
    func deleteProfile(index: Int, completion: @escaping () -> ()) {
        guard let profile = dataProvider.profiles?[index] else { return }
        dataProvider.deleteProfile(profile: profile, index: index) {
            self.updateProfiles()
            completion()
        }
    }
    
    // MARK: - Private functions
    private func updateProfiles() {
        guard let profiles = dataProvider.profiles else { return }
        self.profiles = profiles
    }
}
