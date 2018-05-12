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


class homeview: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    //values
    
    var userlong = 0.1
    var userlat = 0.1
    
    var visitlog = PFObject(className:"visitlog")

    
    
    
    
    var manager:CLLocationManager!

    @IBOutlet weak var mymap: MKMapView!
    
    @IBOutlet weak var userloc: UILabel!
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        

        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        

        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //userLocation - there is no need for casting, because we are now using CLLocation object
        
        let userLocation:CLLocation = locations[0]
        
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        
        userlong = userLocation.coordinate.latitude
        
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 5.0
        
        let lonDelta:CLLocationDegrees = 5.0
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        let annotation = MKPointAnnotation()
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        self.visitlog["pos"] = PFGeoPoint(latitude:latitude, longitude:longitude)
        self.visitlog.saveInBackground()

        

        
        annotation.coordinate = coordinate
        
        annotation.title = "您的位置"
        self.mymap.addAnnotation(annotation)

        
        mymap.setRegion(region, animated: false)
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                
                
                if let p = placemarks?[0] {
                    if let addressbook = placemarks?[0].addressDictionary{
                    print(addressbook)
                    self.visitlog["problem"] = addressbook
                    self.visitlog.saveInBackground()

                        var city:String = ""
                        var prov:String = ""
                        var district:String = ""
                if(addressbook["CountryCode"] != nil){
                    let country = addressbook["Country"] as! String

                    if (addressbook["CountryCode"] as! String) == "CN"{
                        
                        city = addressbook["City"] as! String
                        prov = addressbook["State"] as! String
                        
                        if (addressbook["SubLocality"] != nil){
                        district = addressbook["SubLocality"] as! String
                            self.userloc.text = "\(prov),\(city),\(district)"
                        self.visitlog["district"] = district
                        }else{
                            self.userloc.text = "\(prov),\(city)"
                        }
                    }else{
                        city = addressbook["City"] as! String
                        prov = addressbook["State"] as! String
                        if (addressbook["SubLocality"] != nil){
                            district = addressbook["SubLocality"] as! String
                            self.userloc.text = "\(prov),\(city),\(district)"
                            self.visitlog["district"] = district
                        }else{
                            self.userloc.text = "\(prov),\(city)"
                        }

                    }
                    self.visitlog["fullposition"] = addressbook["FormattedAddressLines"]
                    self.visitlog["country"] = country
                    self.visitlog["prov"] = prov
                    self.visitlog["city"] = city

                }else{
                    self.userloc.text = "您在无主之地，就不判断了。。"
                        }




                    self.visitlog.saveInBackground()


                        
                    }
                    
                    
                    
                    
                    
                    //if( p.country != "中国"){
                        //self.userloc.text = "您的位置： \(p.thoroughfare!), \(p.subLocality!), \(p.subAdministrativeArea!)"
                    
                    
                }
                
                
            }
            
        })

        
        manager.stopUpdatingLocation()
        

        
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
