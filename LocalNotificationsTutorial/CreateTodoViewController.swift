//
//  CreateTodoViewController.swift
//  LocalNotificationsTutorial
//
//  Created by Ingenieria y Software on 23/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit
import CoreData
class CreateTodoViewController: UIViewController {

    @IBOutlet weak var textFieldTodoTitle: UITextField!
    @IBOutlet weak var datePickerTodoDate: UIDatePicker!
    @IBOutlet weak var buttonCreated: UIButton!
    var managedObjectContext: NSManagedObjectContext!
    private struct ButtonText{
        static let EditText = "Edit Todo"
        static let AddText = "Create Todo"
    }
    private struct SegueIdentifier{
        static let TodosList = "Show Todos"
    }
    var todo: Todo?{
        didSet{
            textFieldTodoTitle?.text = todo?.title
            datePickerTodoDate?.date = (todo?.date) ?? NSDate()
            if todo != nil{
                buttonCreated?.setTitle(ButtonText.EditText, forState: UIControlState.Normal)
                buttonCreated?.setTitle(ButtonText.EditText, forState: UIControlState.Highlighted)
            }
            else{
                buttonCreated?.setTitle(ButtonText.AddText, forState: UIControlState.Normal)
                buttonCreated?.setTitle(ButtonText.AddText, forState: UIControlState.Highlighted)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        textFieldTodoTitle?.text = todo?.title
        datePickerTodoDate?.date = (todo?.date) ?? NSDate()
        if todo != nil{
            buttonCreated?.setTitle(ButtonText.EditText, forState: UIControlState.Normal)
            buttonCreated?.setTitle(ButtonText.EditText, forState: UIControlState.Highlighted)
        }
        else{
            buttonCreated?.setTitle(ButtonText.AddText, forState: UIControlState.Normal)
            buttonCreated?.setTitle(ButtonText.AddText, forState: UIControlState.Highlighted)
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
    private func createNotification(todo: Todo)
    {
        let notification = UILocalNotification()
        
        notification.alertBody = "Todo Item \"\(todo.title ?? "")\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = todo.date ?? NSDate() // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": todo.uuid ?? ""] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    @IBAction func createTodo(sender: UIButton) {
        if todo == nil {
            let uuid = NSUUID().UUIDString
            let current = Todo.createInManagedObjectContext(self.managedObjectContext!, title: (textFieldTodoTitle?.text)!, date: datePickerTodoDate.date, uuid: uuid)
            createNotification(current)
        }
        else{
            todo?.date = datePickerTodoDate?.date
            todo?.title = textFieldTodoTitle?.text
            Todo.save(self.managedObjectContext!)
        }
        performSegueWithIdentifier(SegueIdentifier.TodosList, sender: sender)
    }
}
