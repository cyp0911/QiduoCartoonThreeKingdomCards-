//
//  upload.swift
//  奇多三国卡
//
//  Created by 陈音澎 on 2/8/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit


class upload: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("image took")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        importimage.image = image
        
        
        
    }
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    
    
    
    @IBOutlet weak var importimage: UIImageView!
    
    @IBAction func importbutton(sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func pause(sender: AnyObject) {
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(indicator)
        indicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()

        
    }
    
    @IBAction func alertbtn(sender: AnyObject) {
        let alert = UIAlertController(title: "Hey there!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    @IBAction func restore(sender: AnyObject) {
        indicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
