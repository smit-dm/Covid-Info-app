//
//  ViewController.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-17.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        logo.CircleImg()
        txtDeaths.Rounded()
        txtTotal.Rounded()
        txtRecovered.Rounded()
        percent1.Rounded()
        info.Rounded()
        percent2.Rounded()
    }
    
    
    
    func getData()
    {
        for value in data
        {
            worldTotal = value.totalConfirmed
            worldRecovered = value.totalRecovered  ?? 0
            worldDeaths = value.totalDeaths  ?? 0
            deathRatio = Double(Double(worldDeaths) * 100 / Double(worldTotal))
            recoveryRatio = Double(Double(worldRecovered) * 100 / Double(worldTotal))
            percent1.text = "Recovery rate \n \(String(format: "%.2f", recoveryRatio))%"
            percent2.text = "Death rate \n \(String(format: "%.2f", deathRatio))%"
            txtTotal.text = "Total \n \(String(worldTotal))"
            txtRecovered.text = "Recovered \n \(String(worldRecovered))"
            txtDeaths.text = "Deaths \n \(String(worldDeaths))"
        }
    }

   //
}

