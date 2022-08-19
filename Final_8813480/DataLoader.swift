//
//  DataLoader.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-17.
//

import Foundation

public class DataLoader{
    
   @Published var userData = [WelcomeElement]()
    init(){
        load()
        sort()
    }
        //Loading JSON Data into a Array
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json")
        {
            do{
            let data = try Data(contentsOf: fileLocation)
                let dataFromJson = try JSONDecoder().decode([WelcomeElement].self, from: data)
                self.userData = dataFromJson
        } catch{
            print(error)
        }
        }
    }
    
    //Sorting Data
    func sort(){
        self.userData = self.userData.sorted(by: {$0.totalConfirmed < $1.totalConfirmed})
    }
    
}
