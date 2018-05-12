//
//  thanks.swift
//  奇多三国卡
//
//  Created by 陈音澎 on 2016-02-19.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit
import iAd

class thanks: UIViewController {
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toziliao" )
        {
            let ikinciEkran = segue.destinationViewController as! ziliao
            
            ikinciEkran.baike = "http://tieba.baidu.com/home/main?un=Simon%D0%A1%B0%D7&fr=home"
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        canDisplayBannerAds = true
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
