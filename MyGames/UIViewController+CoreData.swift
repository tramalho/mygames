//
//  UIViewController+CoreData.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 11/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import CoreData
import UIKit

extension UIViewController {

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
