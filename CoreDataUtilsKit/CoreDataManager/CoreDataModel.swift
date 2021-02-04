//
//  CoreDataModel.swift
//  Hager Data Kit
//
//  Created by RGMC on 17/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import CoreData

/**
 Protocol to facilitate the use of core data with `CoreDataManager` class
 Gives methods to manage the corresponding entity
 */
public protocol CoreDataModel: NSManagedObject {
    /**
     The name of the core data entity
     */
    static var entityName: String { get }
    /**
     The attribute name of the primary key of the entity; basically an id used on CRUD operations
     */
    static var primaryKey: String { get }
}

extension CoreDataModel {
    
    /**
     Get Value of current entity  primary key
     */
    var primaryKey: PrimaryKeyType? {
        primaryKeyfrom(self.value(forKey: Self.primaryKey))
    }
}

// MARK: - Core Data Model extension
extension CoreDataModel {
    
    /**
     Create a basic fetch request
     - returns: a fetch request based on the entity's name
     */
    public static func fetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: self.entityName)
    }
    
    /**
     Create a basic predicate
     - parameter primaryKey: primary key of the entity
     - returns: a predicate based on the given primary key
     */
    static func predicate(with primaryKey: PrimaryKeyType) -> NSPredicate {
        return NSPredicate(format: "\(Self.primaryKey) = %@", primaryKey.value)
    }
    
    // MARK: Core Data Model GET
    
    /**
     Create an entity
     - returns: the instance of the created entity or nil
     */
    public static func create() -> Self? {
        CoreDataManager.default.create()
    }
    
    /**
     Find an entity based on the given primary key if it exists, otherwise create it
     - parameter primaryKey: primary key of the entity to find
     - returns: the instance of the found or created entity
     */
    public static func findOrCreate(with primaryKey: PrimaryKey?) -> Self? {
        let value = primaryKeyfrom(primaryKey)
        guard let typedKey = value else { return nil }
        return CoreDataManager.default.fetchOrCreate(with: typedKey)
    }
    
    /**
     Get all entities compliant with the given predicate
     - parameter predicate: a predicate or nil
     - returns: all found entities
     */
    public static func getAll(predicate: NSPredicate? = nil,
                              sortBy:String? = nil,
                              ascending:Bool? = true) -> [Self] {
        CoreDataManager.default.fetch(predicate: predicate, sortedKey: sortBy, ascending: ascending)
    }
    
    /**
     Get the entity corresponding to the given primary key
     - parameter primaryKey: primary key of the entity to find
     - returns: the instance of the found entity or nil if not found
     */
    public static func get(with primaryKey: PrimaryKey?) -> Self? {
        let value = primaryKeyfrom(primaryKey)
        guard let myPrimaryKey = value else { return nil }
        return CoreDataManager.default.fetch(with: myPrimaryKey).first
    }

    /**
     Get the entities corresponding to the given primary keys
     - parameter primaryKeys: primary keys of the entities to find
     - returns: all found entities
     */
    public static func getAll(with primaryKeys: [PrimaryKey]) -> [Self] {
        let typedKeys = primaryKeys.map { oneValue in
            return primaryKeyfrom(oneValue)
        }
        return self.getAll(predicate: NSPredicate(format: "\(Self.primaryKey) IN %@", typedKeys.map { $0?.value }))
    }
    
    /**
     Delete the entity corresponding to the given primary key
     - parameter primaryKey: primary key of the entity to delete
     - returns: the remaining entities
     */
    @discardableResult public static func delete(with primaryKey: PrimaryKey) -> [Self] {
        guard let typedValue = primaryKeyfrom(primaryKey) else { return [] }
        return CoreDataManager.default.delete(with: typedValue)
    }
    
    /**
     Delete the entity corresponding to the given predicate
     - parameter predicate: the predicate of the entities to delete
     - returns: all remaining entities
     */
    @discardableResult public static func deleteAll(predicate: NSPredicate? = nil) -> [Self] {
        return CoreDataManager.default.delete(predicate: predicate)
    }
    
    /**
     Delete all entities except given primary keys
     - parameter except: primary keys of the entities to keep
     - returns: all remaining entities
     */
    @discardableResult public static func deleteAll(except primaryKeys: [PrimaryKey]) -> [Self] {
        let typedKeys = primaryKeys.map { oneValue in
            return primaryKeyfrom(oneValue)
        }
        return self.deleteAll(predicate: NSPredicate(format: "NOT \(Self.primaryKey) IN %@", typedKeys.map { $0?.value }))
    }
}
