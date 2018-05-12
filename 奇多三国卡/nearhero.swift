//
//  homeview.swift
//  奇多三国卡
//
//  Created by 陈音澎 on 2/9/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import MapKit
import CoreLocation
import Parse
import ParseUI
import Social


class nearhero: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    //values
    
    var userlong = 0.1
    var userlat = 0.1
    
    @IBOutlet weak var heroloc: MKMapView!
    
    @IBOutlet weak var scrollhero: UIScrollView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var loctext: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var first: UILabel!
    
    @IBOutlet weak var heroimage: UIImageView!
    
    var manager:CLLocationManager!
    
    var nameofhero: String!
    var disofhero: String!
    var locofhero: String!
    var numofhero = 0
    var indexofhero: String!
    let popover = Popover()
    var showbutton = false
    var cnma = true


    @IBAction func shareloc(sender: AnyObject) {
        if(!NSUserDefaults.standardUserDefaults().boolForKey("showbutton?")){
        }else{
            showbutton = true
            
        }
        
        
        
        let startPoint = CGPoint(x: self.view.frame.width - 40, y: 55)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 230, height: 160))
        popover.show(aView, point: startPoint)
        
        let wbbtn = UIButton()
        wbbtn.setImage(UIImage(named: "weiboicon.png"), forState: .Normal)
        wbbtn.frame = CGRectMake(20, 20, 50, 50)
        wbbtn.addTarget(self, action: Selector("toweibo:"), forControlEvents: .TouchUpInside)
        aView.addSubview(wbbtn)
        
        
        if(showbutton == true){
            let frbtn = UIButton()
            frbtn.setImage(UIImage(named: "friendicon.png"), forState: .Normal)
            frbtn.frame = CGRectMake(90, 20, 50, 50)
            frbtn.addTarget(self, action: Selector("tofriend:"), forControlEvents: .TouchUpInside)
            aView.addSubview(frbtn)
            
            let wxbtn = UIButton()
            wxbtn.setImage(UIImage(named: "weixinicon.png"), forState: .Normal)
            wxbtn.frame = CGRectMake(160, 20, 50, 50)
            wxbtn.addTarget(self, action: Selector("toweixin:"), forControlEvents: .TouchUpInside)
            aView.addSubview(wxbtn)
        }
        
        if(cnma == true){
            let fbbtn = UIButton()
            fbbtn.setImage(UIImage(named: "facebookicon.png"), forState: .Normal)
            fbbtn.frame = CGRectMake(20, 90, 50, 50)
            fbbtn.addTarget(self, action: Selector("tofacebook:"), forControlEvents: .TouchUpInside)
            aView.addSubview(fbbtn)
            
            
            let twbtn = UIButton()
            twbtn.setImage(UIImage(named: "twittericon.png"), forState: .Normal)
            twbtn.frame = CGRectMake(90, 90, 50, 50)
            twbtn.addTarget(self, action: Selector("totwitter:"), forControlEvents: .TouchUpInside)
            aView.addSubview(twbtn)
        }
        

        
        
    }
    
    
    
    func toweibo(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            shareController.setInitialText("离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册")
        let imagenow = screenshot()
        
        shareController.addImage(imagenow)
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
            self.presentViewController(shareController, animated: true, completion: nil)
        

    }
    
    func tofacebook(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareController.setInitialText("离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册")
        let imagenow = screenshot()
        shareController.addImage(imagenow)
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        self.presentViewController(shareController, animated: true, completion: nil)
        
        
    }
    //分享文本
    
    func totwitter(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareController.setInitialText("离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册")
        
        
        let imagenow = screenshot()
        
        shareController.addImage(imagenow)
        shareController.addURL(NSURL(string: "https://itunes.apple.com/app/id1081172365?mt=8"))
        
        self.presentViewController(shareController, animated: true, completion: nil)
        
        
    }

    
    func sendText(text:String, inScene: WXScene)->Bool{
        let req=SendMessageToWXReq()
        req.text=text
        req.bText=true
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    
    
    ///分享图片
    func sendImage(image:UIImage, inScene:WXScene)->Bool{
        let ext=WXImageObject()
        ext.imageData=UIImagePNGRepresentation(image)
        
        let message=WXMediaMessage()
        message.title="当年收集过的奇多三国卡高清版来了～"
        message.description="离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册"
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text="离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册"
        req.message=message
        req.bText=false
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    
    func sendlink(image:UIImage, insCene:WXScene) ->Bool{
        let message=WXMediaMessage()
        message.title="看看离自己最近的三国英雄故里"
        message.description="离我最近的三国英雄是：\(nameofhero), 籍贯: \(locofhero), \(disofhero). 想找离自己最近的三国英雄？ 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册"
        message.mediaTagName="qiduo"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
    
    var ext =  WXWebpageObject()
    ext.webpageUrl = "https://appsto.re/cn/k_Mqab.i"
    message.mediaObject = ext
    
    var req =  SendMessageToWXReq()
    req.bText = false
    req.message = message
    req.scene=Int32(insCene.rawValue)

    return WXApi.sendReq(req)
    }
    
    
    func tofriend(sender: AnyObject) {
        popover.dismiss()
        //sendText("做个实验～", inScene: WXSceneTimeline)
        //sendImage(biggraph.image!, inScene: WXSceneTimeline) //分享图片到朋友圈，假设项目中已经添加了一张名曰MyImage.png的大图片作为分享图片
        let imagenow = screenshot()
        sendlink(imagenow, insCene: WXSceneTimeline )


    }
    
    func toweixin(sender: AnyObject) {
        popover.dismiss()
        //sendText("做个实验～", inScene: WXSceneTimeline)
        let imagenow = screenshot()
        sendlink(imagenow, insCene: WXSceneSession )
    }
    
    
    func onResp(resp: BaseResp!) {
        //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
                if resp.isKindOfClass(SendMessageToWXResp){//确保是对我们分享操作的回调
                    if resp.errCode == WXSuccess.rawValue{//分享成功
                        NSLog("分享成功")
                    }else{//分享失败
                        NSLog("分享失败，错误码：%d, 错误描述：%@", resp.errCode, resp.errStr)
                    }
                }
        
        
        
        
    }

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let locale = NSLocale.currentLocale()
        if let country = locale.objectForKey(NSLocaleCountryCode) as? String {
            if country == "CN" {
                print("An American")
                self.cnma = false
            } else {
                print("Not an American")
                self.cnma = true
            }
        }
        
        
        
        
        
        
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        //scrollview
       

        

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let query = PFQuery(className:"home")
                query.whereKey("geopoint", nearGeoPoint:geoPoint!)
                query.limit = 1
                query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error) -> Void in
                    let place = objects
                    for object in place! {
                        let hero = object
                        self.name.text = hero["name"] as? String
                        self.loctext.text = "\(hero["oldlocname"] as! String),现\(hero["newlocname"] as! String)"
                        
                        
                        
                        let latitude:CLLocationDegrees = hero["geopoint"]!.latitude
                        
                        let longitude:CLLocationDegrees = hero["geopoint"]!.longitude

                        
                        let latDelta:CLLocationDegrees = 5.0
                        
                        let lonDelta:CLLocationDegrees = 5.0
                        
                        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                        
                        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                        
                        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        
                        let annotation = MKPointAnnotation()
                        
                        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                        let loc = CLLocation(latitude: latitude, longitude: longitude)
                        let userloc = CLLocation(latitude: (geoPoint?.latitude)!, longitude: (geoPoint?.longitude)!)
                        let distances = userloc.distanceFromLocation(loc)
                        print(distances)
                        self.distance.text = NSString(format: "距离您 %.2f 公里", (distances / 1000)) as String
                        self.disofhero = NSString(format: "距离 %.2f 公里", (distances / 1000)) as String
                        self.nameofhero = "\(hero["name"] as! String) 字\(hero["word"] as! String)"
                        self.locofhero = "古:\(hero["oldlocname"] as! String), 现:\(hero["newlocname"] as! String)"
                        
                        self.numofhero = hero["num"] as! Int
                        
                        if (self.numofhero >= 1 && self.numofhero <= 9){
                            
                            self.indexofhero = "0\(self.numofhero)"
                            
                        }else if(self.numofhero >= 10 && self.numofhero <= 99){
                            self.indexofhero = "\(self.numofhero)"
                            
                            
                        }

                        
                        
                        

                        
                        annotation.coordinate = coordinate
                        
                        annotation.title = "\(hero["name"] as! String) 字\(hero["word"] as! String)  故里"
                        annotation.subtitle = "古:\(hero["oldlocname"] as! String), 现:\(hero["newlocname"] as! String)"
                        self.heroloc.addAnnotation(annotation)
                        
                        
                        self.heroloc.setRegion(region, animated: true)
                    }

                })
                
                    
                    
                }

            }
        
    
        // User's location
            // Create a query for places

        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func screenshot() -> UIImage {
        
        var imageSize: CGSize = CGSizeZero
        
        let orientation: UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if UIInterfaceOrientationIsPortrait(orientation) {
            imageSize = UIScreen.mainScreen().bounds.size
        } else {
            imageSize = CGSizeMake(UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        for window in UIApplication.sharedApplication().windows {
            CGContextSaveGState(context)
            CGContextTranslateCTM(context, window.center.x, window.center.y)
            CGContextConcatCTM(context, window.transform)
            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y)
            if (orientation == UIInterfaceOrientation.LandscapeLeft) {
                CGContextRotateCTM(context, CGFloat(M_PI_2))
                CGContextTranslateCTM(context, 0, -imageSize.width);
            } else if (orientation == UIInterfaceOrientation.LandscapeRight) {
                CGContextRotateCTM(context, CGFloat(-M_PI_2))
                CGContextTranslateCTM(context, -imageSize.height, 0)
            } else if (orientation == UIInterfaceOrientation.PortraitUpsideDown) {
                CGContextRotateCTM(context, CGFloat(M_PI))
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
            }
            
            if window.respondsToSelector(Selector("drawViewHierarchyInRect:afterScreenUpdates:")) {
                window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates:true)
            } else {
                window.layer.renderInContext(context)
            }
            CGContextRestoreGState(context)
            
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image;
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
