//
//  TodoTableViewController.swift
//  LocalNotificationsTutorial
//
//  Created by Ingenieria y Software on 23/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit
import CoreData
class TodoTableViewController: UITableViewController {
    var todos = [Todo](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var managedObjectContext: NSManagedObjectContext!
    private struct SegueIdentifier{
        static let CreateTodo = "Edit Todo"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier
        {
            if let cvc = segue.destinationViewController as? CreateTodoViewController
            {
                switch identifier
                {
                case SegueIdentifier.CreateTodo:
                    if let data = sender as? Todo{
                        cvc.todo = data
                    }
                default: break
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        fetchTodos()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    private func fetchTodos(){
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        do{
            if let fetchResults = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [Todo] {
                todos = fetchResults
            }
        }
        catch {
            print(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as? TodoTableViewCell
        let todo = todos[indexPath.row]
        cell?.todoTitleLabel.text = todo.title
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        let dateString = formatter.stringFromDate(todo.date ?? NSDate())
        cell?.todoDateLabel.text = dateString
        cell?.buttonEdit.tag = indexPath.row
        cell?.buttonEdit.addTarget(self, action: "edit:", forControlEvents: UIControlEvents.TouchUpInside)
        cell?.buttonDelete.addTarget(self, action: "deleteTodo:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell!
    }
    func deleteTodo(button: UIButton) {
        let todo = todos[button.tag]
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! as [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as? String == todo.uuid) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        todos.removeAtIndex(button.tag)
        Todo.delete(managedObjectContext, todo:todo)
        tableView.reloadData()
    }
    func edit(button: UIButton){
        let todo = todos[button.tag]
        performSegueWithIdentifier(SegueIdentifier.CreateTodo, sender: todo)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
