//
//  ViewController.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-17.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var txtDeaths: UILabel!
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var assesBtn: UIButton!
    @IBOutlet weak var avoidBtn: UIButton!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var txtRecovered: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    var worldTotal : Int = 0;
    var worldRecovered  : Int = 0;
    var worldDeaths : Int = 0;
    var data = DataLoader().userData
    var deathRatio = 0.0
    var recoveryRatio = 0.0
    var locationManager = CLLocationManager()
    var lat = 0.0
    var lon = 0.0
    var coordinates:[CLLocation] = []
    var closest:CLLocation?
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }
       
        // After Loading the view
       
        // Do any additional setup after loading the view.
        getData()
        logo.CircleImg()
        txtDeaths.Rounded()
        txtTotal.Rounded()
        txtRecovered.Rounded()
        percent1.Rounded()
        info.Rounded()
        percent2.Rounded()
        print(closest?.coordinate.latitude ?? 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon =  location.coordinate.longitude
            currentLocation = CLLocation(latitude: lat, longitude: lon)
            
            
        }
    }
    
    override func loadView() {
        super.loadView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        closest = coordinates.min(by:{ $0.distance(from: currentLocation ?? CLLocation(latitude: 52.12345, longitude: 13.54321)) < $1.distance(from: currentLocation ?? CLLocation(latitude: 52.12345, longitude: 13.54321)) })
        
    }
    
    
    func getData()
    {
        for global in data
        {
            worldTotal = global.totalConfirmed
            worldRecovered = global.totalRecovered  ?? 0
            worldDeaths = global.totalDeaths  ?? 0
            deathRatio = Double(Double(worldDeaths) * 100 / Double(worldTotal))
            recoveryRatio = Double(Double(worldRecovered) * 100 / Double(worldTotal))
            percent1.text = "Recovery rate \n \(String(format: "%.2f", recoveryRatio))%"
            percent2.text = "Death rate \n \(String(format: "%.2f", deathRatio))%"
            txtTotal.text = "Total \n \(String(worldTotal))"
            txtRecovered.text = "Recovered \n \(String(worldRecovered))"
            txtDeaths.text = "Deaths \n \(String(worldDeaths))"
            for country in global.areas
            {
                let tempLon = country.long ?? 0.00
                let tempLat = country.lat ?? 0.00
                coordinates.append(CLLocation(latitude: tempLat, longitude: tempLon))
                
//                if (country.lat == closest?.coordinate.latitude && country.long == closest?.coordinate.longitude) {
//                    print(country.totalConfirmed)
//                    print(country.totalDeaths ?? 0)
//                    print(country.totalRecovered ?? 0)
//                    print(country.totalRecoveredDelta ?? 0)
//                    print(country.totalDeathsDelta ?? 0)
//                    print(country.totalConfirmedDelta ?? 0)
//                    print(country.lastUpdated ?? 0)
//                    print(country.lat ?? 0)
//                    print(country.long ?? 0)
//                    print(country.parentID ?? 0)
//                }
                
            }
        }
    }
    

   //
}
/*
 override func viewDidLoad() {
     super.viewDidLoad()
      func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }
     
     //Clean all fields
     city.text = ""
     weather.text = ""
     temp.text = ""
     humidity.text = ""
     wind.text = ""
     
     // After Loading the view
     locationManager.delegate = self
     locationManager.desiredAccuracy = kCLLocationAccuracyBest
     locationManager.requestAlwaysAuthorization()
     locationManager.requestWhenInUseAuthorization()
     locationManager.startUpdatingLocation()
     backButton.isEnabled = false
 }
 
 //Function for Location
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     print(locations)
     if let location = locations.first {
         locationManager.stopUpdatingLocation()
         print(location.coordinate.latitude)
         print(location.coordinate.longitude)
         getWeatherData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
     }
 }
 
 
 */
