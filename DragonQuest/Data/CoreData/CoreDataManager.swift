//
//  CoreDataManager.swift
//  DragonQuest
//
//  Data Layer - Core Data Stack Manager
//

import Foundation
import CoreData

/// Core Data stack'i yöneten singleton manager
final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DragonQuest")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Production'da bu hata uygun şekilde handle edilmeli
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Background Context
    
    /// Background işlemler için yeni context oluşturur
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    // MARK: - Save Context
    
    /// Context'i kaydeder
    /// - Parameter context: Kaydedilecek context (default: viewContext)
    func saveContext(_ context: NSManagedObjectContext? = nil) throws {
        let contextToSave = context ?? viewContext
        
        guard contextToSave.hasChanges else { return }
        
        do {
            try contextToSave.save()
        } catch {
            let nserror = error as NSError
            print("Error saving context: \(nserror), \(nserror.userInfo)")
            throw CoreDataError.saveFailed(nserror)
        }
    }
    
    // MARK: - Fetch
    
    /// Generic fetch metodu
    func fetch<T: NSManagedObject>(
        _ fetchRequest: NSFetchRequest<T>,
        context: NSManagedObjectContext? = nil
    ) throws -> [T] {
        let contextToUse = context ?? viewContext
        
        do {
            return try contextToUse.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            print("Error fetching: \(nserror), \(nserror.userInfo)")
            throw CoreDataError.fetchFailed(nserror)
        }
    }
    
    // MARK: - Delete
    
    /// Entity'yi siler
    func delete(_ object: NSManagedObject, context: NSManagedObjectContext? = nil) throws {
        let contextToUse = context ?? viewContext
        contextToUse.delete(object)
        try saveContext(contextToUse)
    }
    
    /// Batch delete işlemi
    func batchDelete<T: NSManagedObject>(
        _ fetchRequest: NSFetchRequest<T>,
        context: NSManagedObjectContext? = nil
    ) throws {
        let contextToUse = context ?? viewContext
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try contextToUse.execute(deleteRequest)
            try saveContext(contextToUse)
        } catch {
            let nserror = error as NSError
            print("Error batch deleting: \(nserror), \(nserror.userInfo)")
            throw CoreDataError.deleteFailed(nserror)
        }
    }
    
    // MARK: - Count
    
    /// Entity sayısını döndürür
    func count<T: NSManagedObject>(
        _ fetchRequest: NSFetchRequest<T>,
        context: NSManagedObjectContext? = nil
    ) throws -> Int {
        let contextToUse = context ?? viewContext
        
        do {
            return try contextToUse.count(for: fetchRequest)
        } catch {
            let nserror = error as NSError
            print("Error counting: \(nserror), \(nserror.userInfo)")
            throw CoreDataError.countFailed(nserror)
        }
    }
    
    // MARK: - Reset
    
    /// Tüm data'yı siler (Test/Debug için)
    func resetAllData() throws {
        let entities = persistentContainer.managedObjectModel.entities
        
        for entity in entities {
            guard let entityName = entity.name else { continue }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try viewContext.execute(deleteRequest)
        }
        
        try saveContext()
    }
}

// MARK: - Core Data Errors

enum CoreDataError: LocalizedError {
    case saveFailed(NSError)
    case fetchFailed(NSError)
    case deleteFailed(NSError)
    case countFailed(NSError)
    case entityNotFound
    
    var errorDescription: String? {
        switch self {
        case .saveFailed(let error):
            return "Veri kaydedilemedi: \(error.localizedDescription)"
        case .fetchFailed(let error):
            return "Veri alınamadı: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Veri silinemedi: \(error.localizedDescription)"
        case .countFailed(let error):
            return "Sayım yapılamadı: \(error.localizedDescription)"
        case .entityNotFound:
            return "Entity bulunamadı"
        }
    }
}


