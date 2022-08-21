//
//  AssesmentViewController.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-18.
//

import UIKit
import SwiftUI

class AssesmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Self Assessment"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ans1: UITextField!
    @IBOutlet weak var ans2: UITextField!
    @IBOutlet weak var ans3: UITextField!
    @IBOutlet weak var ans4: UITextField!
    
    @IBAction func submit(_ sender: UIButton) {
        let temp1 = ans1.text
        let temp2 = ans2.text
        let temp3 = ans3.text
        let temp4 = ans4.text
        
        if temp1 == "" || temp2 == "" || temp3 == "" || temp4 == "" {
            self.title = "Try again"
        }
        else if temp1 == "yes" && temp2 == "yes" && temp3 == "yes" && temp4 == "yes"{
            self.title = "You have low risk"
        }
        else if temp1 == "no" && temp2 == "no" && temp3 == "no" && temp4 == "no"{
            self.title = "get a covid test"
        }
        else if temp1 == "yes" || temp2 == "yes" || temp3 == "yes" || temp4 == "yes"{
            self.title = "You have medium risk"
        }
        else{
            self.title = "Wrong Input"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
