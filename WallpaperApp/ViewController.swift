//
//  ViewController.swift
//  WallpaperApp
//
//  Created by Tracy Richard on 9/12/16.
//  Copyright © 2016 Jack Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let baseURL = "https://www.reddit.com/r/wallpapers/.json"
    var page : [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "richard-logo.png")
        self.view.reloadInputViews()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ViewController.imageTapped(_:)))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)    }


    @IBAction func pressedLinkedin(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.linkedin.com/in/jackrichard")!)
    }

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func redditButtonPressed(sender: AnyObject) {
        self.appDelegate.showMainPage()
    }
    func imageTapped(img: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.jackwrichard.com")!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "redditSegue" {
//            (segue.destinationViewController as! RedditTableTableViewController).page  = self.page
        }
    }
}

