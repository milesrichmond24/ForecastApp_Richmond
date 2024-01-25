//
//  ViewController.swift
//  ForecastApp_Richmond
//
//  Created by MILES RICHMOND on 1/24/24.
//

import UIKit

class ViewController: UIViewController {
    
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

