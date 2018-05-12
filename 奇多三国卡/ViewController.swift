//
//  ViewController.swift
//  奇多三国卡
//
//  Created by 陈音澎 on 1/23/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import Parse
import CoreTelephony




class ViewController: UIViewController {
    
    var count = 1
    var cocount = "1"
    var cocountbg = "1"
    var direction = 0
    var cardside = true
    var showbutton = false
    var cnma = true
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    
    
    @IBAction func namescale(sender: UISlider) {
        
        count = Int(sender.value)

        
        showimage(count,direc: 3)
        
    }
    
    @IBOutlet weak var slidershow: UISlider!
    
    var receiveIndex = 0
    

    var namelist = ["0","曹操","刘备","孙权","诸葛亮","关羽","周瑜","张飞","孙坚","庞统","董卓","李典","典韦","吕布","乐进","曹丕","赵云","徐晃","张辽","郭嘉","曹仁","许褚","司马懿","于禁","张郃","华雄","袁绍","孙策","荀彧","陆逊","夏侯惇","袁术","颜良","鲁肃","姜维","关平","周仓","文丑","孟获","庞德","夏侯渊","黄忠","陈宫","王允","貂蝉","凌统","徐盛","马超","马腾","黄盖","吕蒙","魏延","马谡","太史慈","张角"]
    
    

    @IBOutlet weak var window3kindom: UIImageView!
    
    @IBOutlet weak var numview: UILabel!
    
    @IBAction func mutemusic(sender: AnyObject) {
        
        mute()
        
        
    }
    
    
    @IBAction func resetbar(sender: AnyObject) {
        
       
        

        count = 1
        
        showimage(count,direc: 3)

        
        //player.play()

    }
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "好的", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }


    let popover = Popover()
    @IBAction func sharebutton(sender: AnyObject) {
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
        shareController.setInitialText("高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
        let imagenow = window3kindom.image
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        self.presentViewController(shareController, animated: true, completion: nil)
        
        
    }
    
    func tofacebook(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareController.setInitialText("高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
        let imagenow = window3kindom.image
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        self.presentViewController(shareController, animated: true, completion: nil)
        
        
    }
    //分享文本
    
    func totwitter(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareController.setInitialText("高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
        
        
        let imagenow = window3kindom.image
        
        shareController.addImage(imagenow)
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        
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
        message.description="高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text="高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
        req.message=message
        req.bText=false
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    
    func sendlink(image:UIImage, insCene:WXScene) ->Bool{
        let message=WXMediaMessage()
        message.title="点击下载当年收集过的奇多三国卡IOS高清版～"
        message.description="高清卡牌第\(count)张:\(namelist[count]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
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
        sendlink(window3kindom.image!, insCene: WXSceneTimeline )
        
        
    }
    
    func toweixin(sender: AnyObject) {
        popover.dismiss()
        //sendText("做个实验～", inScene: WXSceneTimeline)
        sendlink(window3kindom.image!, insCene: WXSceneSession )
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

    
    
    
    
    
    
    
    
      
    func showimage(indexnum:Int,direc:Int) {
        
        slidershow.value = Float(count)
        
        
        if cardside == false{cardside = true}
        
        
        
        if (indexnum >= 1 && indexnum <= 9){
            
            cocount = "0\(indexnum)"
            
        }else if(indexnum >= 10 && indexnum <= 99){
            cocount = "\(indexnum)"

        }
        if direc == 3{
        window3kindom.hidden = true
        }
        window3kindom.image = UIImage(named: "\(cocount)")
        animationFlip(window3kindom, toView: window3kindom, animationTime: 0.5, direction:direc)
        

        numview.text = "No.\(indexnum) \(namelist[indexnum])"
        

    }
    
    @IBOutlet weak var mutebutton: UIButton!
    
    var mutes = false
    func mute(){
        if mutes == false{
            player.play()
            mutebutton.setImage(UIImage(named: "mute"), forState: UIControlState.Normal)
            mutes = true
        }else if (mutes == true){
            player.pause()
            mutebutton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
            mutes = false
        }
        
        
        
    }
    
    
    func flipcard(){
        window3kindom.hidden = true
        
        if (count >= 1 && count <= 9){
            
            cocount = "0\(count)"
            cocountbg = "0\(count)bg"
            
        }else if(count >= 10 && count <= 99){
            cocount = "\(count)"
            cocountbg = "\(count)bg"

            
        }
            
            
            
        

        if(cardside == true){
            window3kindom.image = UIImage(named: "\(cocountbg)")
            cardside = false
        }else if(cardside == false){
            
            window3kindom.image = UIImage(named: "\(cocount)")
                cardside = true
        }
        animationFlip(window3kindom, toView: window3kindom, animationTime: 0.5, direction:3)
        
    }
    
    
    
    
    func animationFlip(fromView:UIView, toView:UIView, animationTime:Float, direction:Int)
    {
        
        UIView.animateWithDuration(NSTimeInterval(animationTime), animations: {
            
            if direction == 1{
                UIView.setAnimationTransition(UIViewAnimationTransition.CurlUp, forView: fromView, cache: true)
            }else if(direction == 2){
                UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: fromView, cache: true)
            }else if(direction == 3){
                UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: fromView, cache: true)
            }
            
            },completion:{completion in
                UIView.animateWithDuration(NSTimeInterval(animationTime), animations: { () -> Void in
                    
                  
                    if direction ==  1 && direction == 2{
                    fromView.hidden = false;
                    toView.hidden = false;

                    UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: toView, cache: true)
                    }else if(direction == 3){
                        fromView.hidden = true;
                        toView.hidden = false;
                        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: toView, cache: true)
                    }
                    
                })
        })
    }
    

    
    
    @IBOutlet weak var tapView: UIImageView!
    
    let tapRec = UITapGestureRecognizer()

    func tappedView(){
        flipcard()
    }

    
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    
    
    @IBOutlet weak var animaimage: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let locale = NSLocale.currentLocale()
        if let country = locale.objectForKey(NSLocaleCountryCode) as? String {
            if country == "CN" {
                self.cnma = false
            } else {
                self.cnma = true
            }
        }
        
        
        
        
        
        
        
        
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("showbutton?")){
            var showbtn = PFQuery(className:"swift")
            showbtn.whereKey("function", equalTo:"showbtn")
            showbtn.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                            if (object["show"] as! Int == 0){
                                self.showbutton = false
                            }else{
                                self.showbutton = true
                                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "showbutton?")
                            }
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
            
        }
        
        var carrierName = ""
        let networkInfo = CTTelephonyNetworkInfo()
        if networkInfo != ""{
        let carrier = networkInfo.subscriberCellularProvider
        
        // Get carrier name
            if carrier != nil{
        carrierName = carrier!.carrierName!
        
        print(carrierName)
        }
        }
        let systemVersion = UIDevice.currentDevice().systemVersion;
        print(systemVersion)
        
        
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("log?")){
            let visitlog = PFObject(className:"visitimes")
            visitlog["carrier"] = "\(carrierName)"
            visitlog["logtime"] = 1
            
            visitlog["sysversion"] = "\(systemVersion)"
            visitlog.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    print("nicesave")
                    print(visitlog.objectId)
                    NSUserDefaults.standardUserDefaults().setObject("\(visitlog.objectId! as String)", forKey: "userid")
                } else {
                    // There was a problem, check error.description
                }
            }
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "log?")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "cn?")
            
            
            
            
            
        }else{
            var visit1 = PFQuery(className:"visitimes")
            let defaults = NSUserDefaults.standardUserDefaults()
            var usid = ""
            if let userIds = defaults.stringForKey("userid")
            {
                print(userIds)
                usid = userIds
                print(usid)
            }
            visit1.getObjectInBackgroundWithId("\(usid)") {
                (visitlog: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let visitlog = visitlog {
                    visitlog["logtime"] = visitlog["logtime"] as! Int + 1
                    visitlog["sysversion"] = "\(systemVersion)"
                    visitlog["carrier"] = "\(carrierName)"
                    visitlog.saveInBackground()
                }
            }
            
        }
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("cn?")){
            
        }

        
        
        
        
        
        
        
        
        
        
        
        
        //test parse
        if(!NSUserDefaults.standardUserDefaults().boolForKey("remind?")){

        displayAlert("浏览提示", message: "1.左右划屏，查看前后卡片。2.点击图片查看卡背。3.晃动手机可随机查看。")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "remind?")

            
            
        }
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0


        
        //navbar colors
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
                
        
        tapView.userInteractionEnabled = true;

        tapRec.addTarget(self, action: "tappedView")
        tapView.addGestureRecognizer(tapRec)
        
        
        //swipt
        let swiperight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        
        swiperight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swiperight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        
        
        let audiopath = NSBundle.mainBundle().pathForResource("historysky", ofType: "mp3")!
        
        do{
        
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audiopath))
        } catch {
            //error print
        }
        
        
        
        
        
        
        
        numview.text = "No.1 \(namelist[1])"
        
        window3kindom.image = UIImage(named: "01")
        window3kindom.layer.cornerRadius = 15.0
        window3kindom.layer.borderWidth = 2
        window3kindom.clipsToBounds = true

        
        
        
        
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
            
            let dice = arc4random_uniform(114) + 1
            
            count = Int(dice)
            
            showimage(count,direc: 3)
            
                    }
        
    }
    
    
    
    
    
    
    func swiped(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if (count >= 2){
                    count--
                }else if(count == 1){
                        let alert = UIAlertController(title: "友情提示", message: "这是第一张，请向左划屏", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "知道", style: .Default, handler: { (action) -> Void in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }))
                    
                    
                    
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                showimage(count,direc: 2)
            case UISwipeGestureRecognizerDirection.Left:
                if (count <= 53) {
                    count++
                }else if(count == 54){
                    let alert = UIAlertController(title: "友情提示", message: "到头了，想看更多电子卡册，请到App store评论支持作者，谢谢!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .Default, handler: { (action) -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                showimage(count,direc: 1)
            default:
                break

                
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
   
    


}

