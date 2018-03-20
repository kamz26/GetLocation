//
//  ViewController.swift
//  GetLocation
//
//  Created by Abhishek K on 07/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController {

    var cllocationManager = CLLocationManager()
    
    
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cllocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            cllocationManager.delegate = self
            cllocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
          
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getMyLocationAction(_ sender: Any) {
        self.cllocationManager.requestAlwaysAuthorization()
        
          cllocationManager.startUpdatingLocation()
    }
    
   
    
}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemark, error) in
            
            DispatchQueue.main.async {
                
                if let placemark = placemark{
                    self.locationLabel.text = placemark[0].subLocality! + ", " + placemark[0].name! + " \(placemark[0].locality!) " + placemark[0].administrativeArea! + " " + placemark[0].postalCode!
                }
            }
        }
    }
    
    
    
}



