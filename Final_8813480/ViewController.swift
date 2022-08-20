//
//  ViewController.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-17.
//

import UIKit
import CoreLocation
//importing Charts
import Charts

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets for all the lables, buttons, images, charts &textview
    @IBOutlet weak var pieCharts: PieChartView!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var txtDeaths: UILabel!
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var assesBtn: UIButton!
    @IBOutlet weak var avoidBtn: UIButton!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var txtRecovered: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    //Initializing Variables
    var totalRecovered = PieChartDataEntry(value: 0)
    var totalDeath = PieChartDataEntry(value: 0)
    var inRecovery = PieChartDataEntry(value: 0)
    var totalConfirmed = [PieChartDataEntry]()
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
    var closestLat:CLLocationDegrees?
    var closestLon:CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // After Loading the view
        getData()
        //Changing Shapes
        logo.CircleImg()
        txtDeaths.Rounded()
        txtTotal.Rounded()
        txtRecovered.Rounded()
        percent1.Rounded()
        info.RoundedView()
        percent2.Rounded()
        //Chart data
//        pieCharts.chartDescription?.text = ""
        totalRecovered.value = Double(worldRecovered)
        totalRecovered.label = "Recovered"
        totalDeath.value = Double(worldDeaths)
        totalDeath.label = "Deaths"
        inRecovery.value = Double(worldTotal - worldRecovered - worldDeaths)
        inRecovery.label = "In Recovery"
        totalConfirmed = [totalRecovered,totalDeath,inRecovery]
        pieCharts.layer.borderWidth = 5
        updateChartData()
        info.isEditable=false
        
    }
    
    //Creating Location Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(locations)
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon =  location.coordinate.longitude
            currentLocation = CLLocation(latitude: lat, longitude: lon)
            }
    }
    //Getting Location from User
    override func loadView() {
        super.loadView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //Hiding Navigation Controller from MainPage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    //Getting Closest Location and Displaying Info in the TextBox
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        closest = coordinates.min(by:{ $0.distance(from: currentLocation ?? CLLocation(latitude: 0, longitude: 0)) < $1.distance(from: currentLocation ?? CLLocation(latitude: 0, longitude: 0)) })
        let coord = closest?.coordinate
        closestLon = coord?.longitude //Latitude & Longitude as String
        closestLat = coord?.latitude
        for global in data
        {
            for country in global.areas where country.lat == closestLat
            {
                let tr:String? = String(country.totalRecovered ?? 0)
                let tc = String(country.totalConfirmed)
                let dn = String(country.displayName)
                let td:String? = String(country.totalDeaths ?? 0)
               info.text = "Covid Info Near You \n Country Name   : \(dn) \n Total Confirmed: \(tc) \n Total Recovered: \(tr ?? "") \n Total Deaths   : \(td ?? "")"
            }
        }
    }
    //Getting Global Data & Creating a Array of CLLocation
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
            }
        }
    }
    
    func updateChartData(){
        let chartDataSet = PieChartDataSet(entries: totalConfirmed,label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
       //let colors = [UIColor(named: "red"), UIColor(named: "blue")]
        chartDataSet.colors = [.green, .blue , .red]
      pieCharts.data = chartData
    }

   //
}
