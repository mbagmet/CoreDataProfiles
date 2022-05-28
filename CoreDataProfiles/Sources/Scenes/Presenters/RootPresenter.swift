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
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: RootPresenterDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Functions
}
