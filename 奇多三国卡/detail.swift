//
//  detail.swift
//  小浣熊水浒卡册
//
//  Created by 陈音澎 on 2/3/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit
import Social
import Parse

class details: UIViewController {
    
    var receivedCellIndex = 0
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var biggraph: UIImageView!
    
    var indexnum = 0
    var cocount = "0"
    var cocountbg = "0"
    var cardside = true
    var buy = false
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
           }

    
    func flipcard(){
        biggraph.hidden = true
        
        if (indexnum >= 1 && indexnum <= 9){
            
            cocount = "0\(indexnum)"
            cocountbg = "0\(indexnum)bg"
            
        }else if(indexnum >= 10 && indexnum <= 99){
            cocount = "\(indexnum)"
            cocountbg = "\(indexnum)bg"
            
            
        }
        
        if(cardside == true){
            biggraph.image = UIImage(named: "\(cocountbg).png")
            cardside = false
        }else if(cardside == false){
            
            biggraph.image = UIImage(named: "\(cocount).png")
            cardside = true
        }
        animationFlip(biggraph, toView: biggraph, animationTime: 0.5, direction:3)
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

    
    //share!
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    var namelist = ["0","曹操","刘备","孙权","诸葛亮","关羽","周瑜","张飞","孙坚","庞统","董卓","李典","典韦","吕布","乐进","曹丕","赵云","徐晃","张辽","郭嘉","曹仁","许褚","司马懿","于禁","张郃","华雄","袁绍","孙策","荀彧","陆逊","夏侯惇","袁术","颜良","鲁肃","姜维","关平","周仓","文丑","孟获","庞德","夏侯渊","黄忠","陈宫","王允","貂蝉","凌统","徐盛","马超","马腾","黄盖","吕蒙","魏延","马谡","太史慈","张角"]
    
    var sharedownload = false

    var showbutton = false
    var cnma = true
    
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
            shareController.setInitialText("高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
            let imagenow = biggraph.image
            shareController.addImage(imagenow)

            shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
            self.presentViewController(shareController, animated: true, completion: nil)
        
            sharedownload = true

    }
    
    func tofacebook(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareController.setInitialText("高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
        let imagenow = biggraph.image
        shareController.addImage(imagenow)

        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        self.presentViewController(shareController, animated: true, completion: nil)
        
        sharedownload = true
        
    }
    //分享文本
    
    func totwitter(sender: AnyObject) {
        popover.dismiss()
        let shareController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareController.setInitialText("高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡")
        
        
        let imagenow = biggraph.image
        
        shareController.addImage(imagenow)
        shareController.addURL(NSURL(string: "https://appsto.re/cn/k_Mqab.i"))
        
        self.presentViewController(shareController, animated: true, completion: nil)
        sharedownload = true

        
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
        message.description="高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text="高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
        req.message=message
        req.bText=false
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    
    func sendlink(image:UIImage, insCene:WXScene) ->Bool{
        let message=WXMediaMessage()
        message.title="点击下载当年收集过的奇多三国卡IOS高清版～"
        message.description="高清卡牌第\(receivedCellIndex+1)张:\(namelist[receivedCellIndex+1]) 当年收藏过的奇多三国卡, APP Store 搜索: 奇多三国卡－电子卡册, #奇多三国卡"
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
        sendlink(biggraph.image!, insCene: WXSceneTimeline )
        sharedownload = true


    }
    
    func toweixin(sender: AnyObject) {
        popover.dismiss()
        //sendText("做个实验～", inScene: WXSceneTimeline)
        sendlink(biggraph.image!, insCene: WXSceneSession )
        sharedownload = true
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

    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "好的", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    

    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(biggraph.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)

        
        
    }
    
    
    
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "保存成功", message: "目标相片已存入相册", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "好的", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "知道了", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("longpressed")
    
        if sharedownload == true{
        
        var refreshAlert = UIAlertController(title: "提示信息", message: "是否保存\(namelist[receivedCellIndex+1])？", preferredStyle: UIAlertControllerStyle.Alert)
        if cardside == true{
            print(cardside)
            refreshAlert = UIAlertController(title: "提示信息", message: "是否保存\(namelist[receivedCellIndex+1])正面？", preferredStyle: UIAlertControllerStyle.Alert)
        }else{
            print(cardside)
            refreshAlert = UIAlertController(title: "提示信息", message: "是否保存\(namelist[receivedCellIndex+1])背面？", preferredStyle: UIAlertControllerStyle.Alert)

        }
        
        
        refreshAlert.addAction(UIAlertAction(title: "同意", style: .Default, handler: { (action: UIAlertAction!) in
            UIImageWriteToSavedPhotosAlbum(self.biggraph.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)        }))
     //displayAlert("保存成功", message: "您已经保存\(namelist[receivedCellIndex])，进入您的手机相册！")
            sharedownload = false

        refreshAlert.addAction(UIAlertAction(title: "取消", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        }else{
            displayAlert("保存失败", message: "分享后可获得一次储存机会~")
        }
        
        
        
        
        //Different code
    }
    
    

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

        
        self.canDisplayBannerAds = true
        
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        longPressRecognizer.minimumPressDuration = 0.5
        self.view.addGestureRecognizer(longPressRecognizer)
        
        
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("remind1?")){
            
            displayAlert("浏览提示", message: "1.长按图片保存图片。2.左右划屏可翻面。")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "remind1?")
            
            
            
        }



        
        
        
        
        
        
        indexnum = receivedCellIndex + 1
        
        if (indexnum >= 1 && indexnum <= 9){
            
            cocount = "0\(indexnum)"
            
        }else if(indexnum >= 10 && indexnum <= 99){
            cocount = "\(indexnum)"
            
        }
        
        
        biggraph.image = UIImage(named: "\(cocount).png")

        //navbar colors
        
        let view = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 30.0)
        )
        view.backgroundColor = UIColor.blueColor()
        
        
        
        self.view.addSubview(view)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        
        print(receivedCellIndex)
        
        
        //swiper
        let swiperight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        
        swiperight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swiperight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        


        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swiped(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("right")
                flipcard()
            case UISwipeGestureRecognizerDirection.Left:
                print("left")
                flipcard()
            case UISwipeGestureRecognizerDirection.Down:
                print("down")
                self.dismissViewControllerAnimated(true, completion: {});
            default:
                break
                
                
            }
        }
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
