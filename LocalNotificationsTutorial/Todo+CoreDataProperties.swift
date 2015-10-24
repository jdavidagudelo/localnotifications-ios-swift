//
//  Todo+CoreDataProperties.swift
//  LocalNotificationsTutorial
//
//  Created by Ingenieria y Software on 23/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Todo{

    @NSManaged var title: String?
    @NSManaged var date: NSDate?
    @NSManaged var uuid: String?
    override  var description : String{
        get{
            return title ?? ""
        }
    }

}
