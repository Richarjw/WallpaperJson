//
//  DetailViewController.swift
//  WallpaperApp
//
//  Created by Tracy Richard on 9/12/16.
//  Copyright © 2016 Jack Richard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var wallpaper : Wallpaper?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.text = "Loading Image..."
        
    }
 
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func pressedMenu(sender: AnyObject) {
        let alertController = UIAlertController(title: "Menu", message: "", preferredStyle: .ActionSheet)
        let ret = UIAlertAction(title: "Return", style: .Default) {
            (action) -> Void in
            self.appDelegate.showMainPage()
        }
        let front = UIAlertAction(title: "Title Page", style: .Default) {
            (action) -> Void in
            self.appDelegate.showTitlePage()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let save = UIAlertAction(title: "Save Image", style: .Default) {
            (action) -> Void in
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!,nil, nil, nil)
        }
        alertController.addAction(ret)
        alertController.addAction(front)
        alertController.addAction(save)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.titleLabel.text = wallpaper?.caption
        if let imageString = wallpaper?.imageUrl {
            if let imageUrl = NSURL(string: imageString) {
                if let imageData = NSData(contentsOfURL: imageUrl) {
                    imageView.image = UIImage(data: imageData)
                } else {
                    print("No data for the given URL")
                }
            }
        }
    }

}
