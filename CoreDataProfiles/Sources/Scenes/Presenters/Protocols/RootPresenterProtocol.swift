//
//  RootPresenterProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

protocol RootPresenterProtocol {
    var delegate: RootPresenterDelegate? { get set }
    var profiles: [Profile] { get }
    var dataProvider: DataProvider { get set }
    
    func setViewDelegate(delegate: RootPresenterDelegate)
    func updateProfiles()
    
    func addProfile(name: String)
    func deleteProfile(index: Int, completion: @escaping () -> ())
}
