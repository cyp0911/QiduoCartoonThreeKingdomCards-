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
import iAd


class bigmap: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    //values
    
    var userlong = 0.1
    var userlat = 0.1
    
    
    
    @IBOutlet weak var adban: ADBannerView!
    
    @IBAction func add(sender: AnyObject) {
        ads.hidden = true
        adban.hidden = true

        
        
        
    }
    
    
    @IBOutlet weak var ads: UIButton!
    
    
    
    
    
    @IBOutlet weak var mmap: MKMapView!
    
    var manager:CLLocationManager!
    
    
    var namelist = ["0","曹操","刘备","孙权","诸葛亮","关羽","周瑜","张飞","孙坚","庞统","董卓","李典","典韦","吕布","乐进","曹丕","赵云","徐晃","张辽","郭嘉","曹仁","许褚","司马懿","于禁","张郃","华雄","袁绍","孙策","荀彧","陆逊","夏侯惇","袁术","颜良","鲁肃","姜维","关平","周仓","文丑","孟获","庞德","夏侯渊","黄忠","陈宫","王允","貂蝉","凌统","徐盛","马超","马腾","黄盖","吕蒙","魏延","马谡","太史慈","张角"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let query = PFQuery(className:"home")
                query.whereKey("geopoint", nearGeoPoint:geoPoint!)
                query.limit = 54
                query.orderByDescending("num")
                query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error) -> Void in
                    let place = objects
                    for object in place! {
                        let hero = object
                        
                        let latitude:CLLocationDegrees = hero["geopoint"]!.latitude
                        
                        let longitude:CLLocationDegrees = hero["geopoint"]!.longitude
                        
                        
                        let latDelta:CLLocationDegrees = 10.0
                        
                        let lonDelta:CLLocationDegrees = 10.0
                        
                        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                        
                        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                        
                        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        
                      
                        
                        
                        
                        let annotation = MKPointAnnotation()
                        
                        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                        
                        
                        annotation.coordinate = coordinate
                        
                        annotation.title = "\(hero["name"] as! String) 字\(hero["word"] as! String) 故里"
                        annotation.subtitle = "古:\(hero["oldlocname"] as! String), 现:\(hero["newlocname"] as! String)"
                        self.mmap.addAnnotation(annotation)
                        
                        
                        self.mmap.setRegion(region, animated: true)
                        

                    }
                    
                })
                
                
                
            }
            
        }
        

        
        
        
        
        
        
        // User's location
        // Create a query for places
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tokaer" )
        {
            let ikinciEkran = segue.destinationViewController as! details
            
            let tmp = (((sender as? MKAnnotationView)!.annotation?.title)!)!
            
            
            let delimiter = " "
            var token = tmp.componentsSeparatedByString(delimiter)
            
            let index = namelist.indexOf("\(token[0])")              // 2
            
            ikinciEkran.receivedCellIndex = index! as Int - 1
            
        }
        
    }
    @IBOutlet weak var mapView: MKMapView!{ //make sure this outlet is connected
        didSet{
            mapView.delegate = self
        }
    }
    
    // MARK: - Map view delegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("AnnotationView Id")
        if view == nil{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView Id")
            view!.canShowCallout = true
            //view!.ani
        } else {
            view!.annotation = annotation
        }
        //view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        let detailButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)

        //view!.image = UIImage(named: "11")
        view!.rightCalloutAccessoryView = detailButton

    
        //swift 1.2
        //view?.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
        
        return view
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("tokaer", sender: view)
        }
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
