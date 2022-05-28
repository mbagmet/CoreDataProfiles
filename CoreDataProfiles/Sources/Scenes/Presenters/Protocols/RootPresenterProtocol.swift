//
//  RootPresenterProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

protocol RootPresenterProtocol {
    var delegate: RootPresenterDelegate? { get set }
    
    func setViewDelegate(delegate: RootPresenterDelegate)
}
