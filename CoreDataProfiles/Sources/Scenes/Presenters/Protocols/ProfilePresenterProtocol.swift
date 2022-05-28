//
//  ProfilePresenterProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

protocol ProfilePresenterProtocol {
    var delegate: ProfilePresenterDelegate? { get set }
    
    func setViewDelegate(delegate: ProfilePresenterDelegate)
}
