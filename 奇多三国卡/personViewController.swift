//
//  personViewController.swift
//  奇多三国卡
//
//  Created by 陈音澎 on 2/1/16.
//  Copyright © 2016 Clark Chen. All rights reserved.
//

import UIKit
import Parse

class personViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
 
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
           
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()


        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.contentInset = UIEdgeInsetsZero;

        
        
        
        
        //status bar to blue
                

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     var namelist = ["曹操","刘备","孙权","诸葛亮","关羽","周瑜","张飞","孙坚","庞统","董卓","李典","典韦","吕布","乐进","曹丕","赵云","徐晃","张辽","郭嘉","曹仁","许褚","司马懿","于禁","张郃","华雄","袁绍","孙策","荀彧","陆逊","夏侯惇","袁术","颜良","鲁肃","姜维","关平","周仓","文丑","孟获","庞德","夏侯渊","黄忠","陈宫","王允","貂蝉","凌统","徐盛","马超","马腾","黄盖","吕蒙","魏延","马谡","太史慈","张角"]
    

    var wordlist = ["孟德", "玄德", "仲谋", "孔明", "云长", "公瑾", "翼德", "文台", "士元", "仲颖", "曼成", "??", "奉先", "文谦", "子桓", "子龙", "公明", "文远", "奉孝", "子孝", "仲康", "仲达", "文则", "儁乂", "??", "本初", "伯符", "文若", "伯言", "元让", "公路", "子义", "子敬", "伯约", "坦之", "??", "??", "??", "令明", "妙才", "汉升", "公台", "子师", "??", "公绩", "文向", "孟起", "寿成", "公覆", "子明", "文长", "幼常", "子义", "??"]
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return namelist.count
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("sgCell", forIndexPath: indexPath) as! sgcell
        
        var indexnum = indexPath.row + 1
        var cocount = "01"
        
        if (indexnum >= 1 && indexnum <= 9){
            
            cocount = "0\(indexnum)"
            
        }else if(indexnum >= 10 && indexnum <= 99){
            cocount = "\(indexnum)"
            
        }
        
        print(indexPath.row)
        print(wordlist[indexPath.row])

        myCell.sgname.text = namelist[indexPath.row] + "  字" + wordlist[indexPath.row]
        
        myCell.sgimage.image = UIImage(named: "\(cocount)")
        
        myCell.orders.text = "\(indexPath.row + 1)"

        myCell.sgimage.layer.borderWidth = 2
        myCell.sgimage.layer.masksToBounds = false
        myCell.sgimage.layer.borderColor = UIColor.blackColor().CGColor
        myCell.sgimage.layer.cornerRadius = myCell.sgimage.frame.height/2
        myCell.sgimage.clipsToBounds = true
        
        
        
        switch (indexPath.row + 1) % 2{
        case 1:
            myCell.contentView.backgroundColor = UIColor(netHex:0x3366CC)
            myCell.sgname.textColor = UIColor.whiteColor()
            myCell.orders.textColor = UIColor.whiteColor()
            myCell.direcimage.image = UIImage(named: "play0.png")
        case 0:
            myCell.contentView.backgroundColor = UIColor(netHex: 0xCCCC66)
            myCell.sgname.textColor = UIColor.blueColor()
            myCell.orders.textColor = UIColor.blueColor()
            myCell.direcimage.image = UIImage(named: "play1.png")
        default:
            myCell.contentView.backgroundColor = UIColor.grayColor()
        }
    

       // myCell.backgroundColor = cellColorForIndex(indexPath)
    
        return myCell
    }

    /*
    func cellColorForIndex(indexPath:NSIndexPath) -> UIColor{
        //cast row and section to CGFloat
        let row = CGFloat(indexPath.row)
        let section = CGFloat(indexPath.section)
        //compute row as hue and section as saturation
        let saturation  = 1.0 - row / CGFloat(namelist.count)
        let hue =  section / CGFloat(1)
        return UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
    }
    
    */
    /*
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCellWithIdentifier("sgCELL") as? sgcell{
            
            var img:UIImage!
            
            var conut = "0"
            
            let indexnum = indexPath.row + 1
            
            if (indexnum >= 1 && indexnum <= 9){
                
                conut = "0\(indexnum)"
                
            }else if(indexnum >= 10 && indexnum <= 99){
                conut = "\(indexnum)"
                
            }
            
            img = UIImage(named: "\(conut).png")
            
            var addtext = [String]()

            
            addtext.append("\(namelist[indexPath.row])" + "\(wordlist[indexPath.row])")
            //print(addtext)
            print(addtext[2])
            
            
            
            cell.configurecell( img, text: addtext[indexPath.row],order: indexnum)
            
            
            switch indexnum % 4{
            case 1:
                cell.contentView.backgroundColor = UIColor(netHex:0x4CB5F5)
            case 2:
                cell.contentView.backgroundColor = UIColor(netHex: 0xB7B8B6)
            case 3:
                cell.contentView.backgroundColor = UIColor(netHex:0x34675C)
            case 0:
                cell.contentView.backgroundColor = UIColor(netHex: 0xB3C100)
            default:
                cell.contentView.backgroundColor = UIColor.whiteColor()

            }
            
            
            cell.backgroundColor = UIColor.blueColor()
            
            
            return cell
        }else {
            return sgcell()
        }
        
        // Configure the cell...
        
    }
*/
    var chosenCellIndex = 0
    
    // ...
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        chosenCellIndex = indexPath.row
        
        // Start segue with index of cell clicked
        self.performSegueWithIdentifier("tokace", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    // This function is called before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destinationViewController as! details
        
        // set a variable in the second view controller with the data to pass
        secondViewController.receivedCellIndex = chosenCellIndex
        
        
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

