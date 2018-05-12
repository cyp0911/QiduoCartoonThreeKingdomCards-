//
//  ziliao.swift
//  名人故里地图
//
//  Created by 陈音澎 on 2/15/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit
import Parse

class ziliao: UIViewController,UIWebViewDelegate {
    
    var receivedCellIndex = 0
    var baike:String = ""
    var links:String = ""
    
    
    
    //indicator
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    func printweb(value: String) {
        // Here you work with mark value
        
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 49, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-49))
        webV.loadRequest(NSURLRequest(URL: NSURL(string: "\(value)")!))
        print(value)
        webV.delegate = self;
        self.view.addSubview(webV)
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        var value = ""
        if baike == "" {
        
            value = "http://baike.baidu.com/link?url=CHwHgmRANKOFVR1ZWG_eYoybGqr0zjmAFxO0sOfs03t-pphspYYnuqjxAQDW3Y7KXSjmiuplILfXhoTXqaUFHK"
        }else{
            value = baike
        }
            
            
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 65, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-49))
        webV.loadRequest(NSURLRequest(URL: NSURL(string: "\(value)")!))
        print(value)
        webV.delegate = self;
        self.view.addSubview(webV)
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        

        
            
        
        
        
        //weblink
        
        
        
        
        
        
        
        
        
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
