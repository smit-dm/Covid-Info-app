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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        txtTotal.text = String(worldTotal)
        txtRecovered.text = String(worldRecovered)
        txtDeaths.text = String(worldDeaths)
    }
    
    
    
    func getData()
    {
        for value in data {
            worldTotal = value.totalConfirmed
            worldRecovered = value.totalRecovered  ?? 0
            worldDeaths = value.totalDeaths  ?? 0
            for something in value.areas {
//                 worldTotal = something.totalConfirmed
//                 worldRecovered = something.totalRecovered
//                 worldDeaths = something.totalDeaths
//                print(something.totalConfirmed)
                for nothing in something.areas {
                    for idk in nothing.areas where idk.totalConfirmed > 100 {
                        print("Works")
                    }
                }
            }
        }
    }

   //
}

