//
//  Todo.swift
//  LocalNotificationsTutorial
//
//  Created by Ingenieria y Software on 23/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import Foundation
import CoreData


class Todo: NSManagedObject{
   
    class func delete(moc: NSManagedObjectContext, todo: Todo){
        do {
            moc.deleteObject(todo)
            try moc.save()
        } catch {
            print(error)
            abort()
        }
    }
    
    class func save(moc: NSManagedObjectContext)
    {
        do {
            try moc.save()
        } catch {
            print(error)
            abort()
        }
    }
    class func getByUuid(moc: NSManagedObjectContext, uuid: String) -> [Todo]?
    {
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        let predicate = NSPredicate(format: "uuid == %@", uuid)
        fetchRequest.predicate = predicate
        do{
            return try moc.executeFetchRequest(fetchRequest) as? [Todo]
        }
        catch{
            return []
        }
    }
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, date: NSDate, uuid: String) -> Todo {
        let todo = NSEntityDescription.insertNewObjectForEntityForName("Todo", inManagedObjectContext: moc) as! Todo
        todo.title = title
        todo.date = date
        todo.uuid = uuid
        do {
            try moc.save()
        } catch {
            print(error)
            abort()
        }
        return todo
    }
}
