//
//  ViewController.swift
//  Weather
//
//  Created by  SENAT on 18/04/2019.
//  Copyright © 2019 <ASi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    
    var hours = [String]()
    var maxTemperature = [Int]()
    var minTemperature = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        city.textColor = UIColor.white
        temperature.textColor = UIColor.white
        apparentTemperature.textColor = UIColor.white
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func chartButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://xml.meteoservice.ru/export/gismeteo/point/140.xml") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            print(parser)
            }.resume()
    }
}




extension ViewController: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "FORECAST" {
            let forecast = Forecast()
            if let hour = attributeDict["hour"] {
                forecast.hour = hour
                hours.append(forecast.hour!)
            }
        }
        if elementName == "TEMPERATURE" {
            let temperature = Temperature()
            if let max = attributeDict["max"] {
                temperature.max = Int(max)
                maxTemperature.append(temperature.max!)
            }
            if let min = attributeDict["min"] {
                temperature.min = Int(min)
                minTemperature.append(temperature.min!)
            }
        }
        print(hours)
        print(maxTemperature)
        print(minTemperature)
    }
}




