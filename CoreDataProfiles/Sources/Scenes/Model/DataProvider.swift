//
//  DataProvider.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation
import CoreData
import UIKit

class DataProvider: DataProviderProtocol {
    
    // MARK: - Properties
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var managedContext = appDelegate?.persistentContainer.viewContext
    
    // MARK: - Felch profiles from NSManagedObject to Profile
    func felchProfiles() -> [Profile]? {
        try? managedContext?.fetch(Profile.fetchRequest())
    }
    
    // MARK: - Add Profile
    func addProfile(name: String, completion: @escaping () -> ()) {
        
        guard let managedContext = managedContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)
        
        guard let entity = entity else { return }
        let profile = NSManagedObject(entity: entity, insertInto: managedContext)
        profile.setValue(name, forKey: "name")

        do {
            try managedContext.save()
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Delete Profile
    func deleteProfile(profile: NSManagedObject, completion: @escaping () -> ()) {
        managedContext?.delete(profile)

        do {
            try managedContext?.save()
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Update Profile
    func updateProfile(profile: NSManagedObject, completion: @escaping () -> ()) {
        do {
            try managedContext?.save()
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
