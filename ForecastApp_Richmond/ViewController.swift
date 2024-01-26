//
//  ViewController.swift
//  ForecastApp_Richmond
//
//  Created by MILES RICHMOND on 1/24/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var date4: UILabel!
    @IBOutlet weak var date3: UILabel!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var date1: UILabel!
    
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var tempToday: UILabel!
    
    @IBOutlet weak var condition4: UILabel!
    @IBOutlet weak var condition3: UILabel!
    @IBOutlet weak var condition2: UILabel!
    @IBOutlet weak var condition1: UILabel!
    @IBOutlet weak var conditionToday: UILabel!
    
    var currentForecast: Forecast = Forecast(cod: "", message: 0, cnt: 0, list: [], city: City(id: 0, name: "", coord: Coord(lat: 0.0, lon: 0.0), country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        retriveForecast()
        
    }

    func retriveForecast() {
        let session = URLSession.shared
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=42.243420&lon=-88.316978&units=imperial&appid=1b1246112df9a42ff33f920ee1147fbc")!
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("\(error)")
            } else {
                if let jsonData = data {
                    print("fetching data")
                    
                    if let forecast = try! JSONDecoder().decode(Forecast?.self, from: jsonData) {
                        self.currentForecast = forecast
                        self.currentForecast.reduceList(days: 5)
                        for day in self.currentForecast.list {
                            print(day.dtTxt)
                        }
                        
                        
                        DispatchQueue.main.async {
                            print("\((self.currentForecast.list[0].weather.description))")
                            self.conditionToday.text = "\(self.currentForecast.list[0].weather[0].description)"
                            self.condition1.text = "\(self.currentForecast.list[1].weather[0].description)"
                            self.condition2.text = "\(self.currentForecast.list[2].weather[0].description)"
                            self.condition3.text = "\(self.currentForecast.list[3].weather[0].description)"
                            self.condition4.text = "\(self.currentForecast.list[4].weather[0].description)"
                            
                            self.tempToday.text = "\(round(10 * self.currentForecast.list[0].main.tempMin) / 10) - \(round(10 * self.currentForecast.list[0].main.tempMax) / 10) ºF"
                            self.temp1.text = "\(round(10 * self.currentForecast.list[1].main.tempMin) / 10) - \(round(10 * self.currentForecast.list[0].main.tempMax) / 10) ºF"
                            self.temp2.text = "\(round(10 * self.currentForecast.list[2].main.tempMin) / 10) - \(round(10 * self.currentForecast.list[0].main.tempMax) / 10) ºF"
                            self.temp3.text = "\(round(10 * self.currentForecast.list[3].main.tempMin) / 10) - \(round(10 * self.currentForecast.list[0].main.tempMax) / 10) ºF"
                            self.temp4.text = "\(round(10 * self.currentForecast.list[4].main.tempMin) / 10) - \(round(10 * self.currentForecast.list[0].main.tempMax) / 10) ºF"
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "EEEE"
                            
                            self.date1.text = "\(formatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(self.currentForecast.list[1].dt))))"
                            self.date2.text = "\(formatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(self.currentForecast.list[2].dt))))"
                            self.date3.text = "\(formatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(self.currentForecast.list[3].dt))))"
                            self.date4.text = "\(formatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(self.currentForecast.list[4].dt))))"
                        }
                    }
                    
                    /*
                    if let json = try? JSONSerialization.jsonObject(with: jsonData) {
                        print(json)
                    }
                    */
                }
            }
        }
        
        dataTask.resume()
    }
}

