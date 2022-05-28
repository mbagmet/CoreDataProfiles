//
//  DataProviderProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData

protocol DataProviderProtocol {
    var profiles: [NSManagedObject]? { get set }
    var profile: NSManagedObject? { get set }
    
    func felchProfilesList()
    func addProfile(name: String, completion: @escaping () -> ())
    func deleteProfile(profile: NSManagedObject, index: Int, completion: @escaping () -> ())
    func updateProfile(profile: NSManagedObject, completion: @escaping () -> ())
}
