//
//  RootPresenterProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData

protocol RootPresenterProtocol {
    var delegate: RootPresenterDelegate? { get set }
    var profiles: [NSManagedObject] { get }
    var dataProvider: DataProvider { get set }
    
    func setViewDelegate(delegate: RootPresenterDelegate)
    func setupProfiles()
    
    func addProfile(name: String)
    func deleteProfile(index: Int, completion: @escaping () -> ())
}
