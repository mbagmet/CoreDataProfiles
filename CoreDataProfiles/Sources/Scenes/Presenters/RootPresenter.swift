//
//  RootPresenter.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

class RootPresenter: RootPresenterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: RootPresenterDelegate?
    var profiles: [Profile] = []
    var dataProvider = DataProvider()
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: RootPresenterDelegate) {
        self.delegate = delegate
    }
    
    func updateProfiles() {
        guard let profiles = dataProvider.felchProfiles() else { return }
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
        guard let profile = dataProvider.felchProfiles()?[index] else { return }
        dataProvider.deleteProfile(profile: profile) {
            self.updateProfiles()
            completion()
        }
    }
}
