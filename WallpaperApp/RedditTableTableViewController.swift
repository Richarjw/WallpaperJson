//
//  RedditTableTableViewController.swift
//  WallpaperApp
//
//  Created by Tracy Richard on 9/12/16.
//  Copyright © 2016 Jack Richard. All rights reserved.
//

import UIKit

class RedditTableTableViewController: UITableViewController {

    var baseURL = "https://www.reddit.com/r/wallpapers/.json"
    let redditCell = "redditCell"
    var tableData = Array<Wallpaper>()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        tableView.scrollEnabled = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }


    // MARK: - Table view data source

    func getJSON() {
        self.tableData = []
        let url = NSURL(string: baseURL)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request) {
            (data,response, error) -> Void in
            if error == nil {
                let swiftyJSON = JSON(data: data!)
                let children = swiftyJSON["data"]["children"].arrayValue
                
                for title in children {
                    
                    let nextTitle = title["data"]["title"].stringValue
                    let nextImage = title["data"]["url"].stringValue
                    let newWallpaper = Wallpaper(caption: nextTitle, imageUrl: nextImage)
                    self.tableData.append(newWallpaper)
                    self.do_table_refresh()
          
                }
                
            } else {
                print("There was an error")
                
            }
        }
        task.resume()
      
    }
    func do_table_refresh() {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
        
    }
    @IBAction func pressedTitle(sender: AnyObject) {
        self.appDelegate.showTitlePage()
    }
    

    @IBAction func pressedNext(sender: AnyObject) {
        let url = NSURL(string: baseURL)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request) {
            (data,response, error) -> Void in
            if error == nil {
                let swiftyJSON = JSON(data: data!)
                let next = swiftyJSON["data"]["after"].stringValue
                self.baseURL = "https://www.reddit.com/r/wallpapers/.json?count=25&after=" + next
                print(self.baseURL)
                
            } else {
                print("There was an error")
                
            }
        }
        task.resume()

        self.getJSON()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(redditCell, forIndexPath: indexPath)
        cell.textLabel?.text = tableData[indexPath.row].caption
       
        return cell
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: self)

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let wallpaper = tableData[indexPath.row]
                (segue.destinationViewController as! DetailViewController).wallpaper = wallpaper
            }
        }
    }
 
    

}
