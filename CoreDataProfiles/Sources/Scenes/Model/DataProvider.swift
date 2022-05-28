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
    
    var profiles: [NSManagedObject]?
    var profile: NSManagedObject?
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var managedContext = appDelegate?.persistentContainer.viewContext
    
    // MARK: - Show Profiles
    func felchProfilesList() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Profile")
        
        do {
            profiles = try managedContext?.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
            profiles?.append(profile)
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Delete Profile
    func deleteProfile(profile: NSManagedObject, index: Int, completion: @escaping () -> ()) {
        managedContext?.delete(profile)

        do {
            try managedContext?.save()
            profiles?.remove(at: index)
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Update Profile
    func updateProfile(profile: NSManagedObject, completion: @escaping () -> ()) {
        // TODO
    }
}
