//
//  AlertViewController.swift
//  LocalNotificationsTutorial
//
//  Created by Ingenieria y Software on 24/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit
import CoreData
class AlertViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var labelTodoTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        if let uuid = NSUserDefaults.standardUserDefaults().valueForKey(TodoKey.CurrentNotification) as? String
        {
            if let todos = Todo.getByUuid(managedObjectContext, uuid: uuid)
            {
                if todos.count > 0
                {
                    labelTodoTitle?.text = todos[0].title
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
