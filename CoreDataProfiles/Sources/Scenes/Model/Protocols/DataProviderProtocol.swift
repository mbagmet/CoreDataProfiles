//
//  DataProviderProtocol.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData

protocol DataProviderProtocol {
    func felchProfiles() -> [Profile]?
    func addProfile(name: String, completion: @escaping () -> ())
    func deleteProfile(profile: NSManagedObject, completion: @escaping () -> ())
    func updateProfile(profile: NSManagedObject, completion: @escaping () -> ())
}
