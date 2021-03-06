//
//  ProfilePresenterProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

protocol ProfilePresenterProtocol {
    var delegate: ProfilePresenterDelegate? { get set }
    var profile: Profile? { get }
    var dataProvider: DataProvider { get set }
    
    func setViewDelegate(delegate: ProfilePresenterDelegate)
    func updateProfile()
}
