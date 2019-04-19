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
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var hours = [String]()
    var maxTemperature = [Int]()
    var minTemperature = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor.white
        city.textColor = color
        text.textColor = color
        text.text = "The chart contains information about temperature and apparent temperature"
        weather.textColor = color
        date.textColor = color
        time.textColor = color
        
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.red.cgColor
        
        parserXML()
        currentDateAndTime()
        
    }
    
    @IBAction func chartButton(_ sender: UIButton) {
        
    }
    
    func parserXML() {
        
        guard let url = URL(string: "https://xml.meteoservice.ru/export/gismeteo/point/140.xml") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            }.resume()
    }
    
    func currentDateAndTime() {
        
        let date = Date()
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm"
        let time = formatterTime.string(from: date)
        self.time.text = time
        
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd.MM.yyyy"
        let fdate = formatterDate.string(from: date)
        self.date.text = fdate
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? ChartViewController else { return }
        dvc.maxValues = maxTemperature
        dvc.minValues = minTemperature
    }
}




extension ViewController: XMLParserDelegate {

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
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
    }
}




