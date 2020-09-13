//
//  ConsoleManager.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 13/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import CoreData

class PlatformManager {
    
    static let shared = PlatformManager()
    var platforms:[Platform] = []
    
    private init() {}
    
    func load(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            platforms = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func delete(with context: NSManagedObjectContext, index:Int) {
        let console = platforms[index]
        context.delete(console)
        do {
            try context.save()
            
        } catch  {
            print(error.localizedDescription)
        }
    }
}
