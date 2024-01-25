//
//  AppData.swift
//  ForecastApp_Richmond
//
//  Created by MILES RICHMOND on 1/25/24.
//

import Foundation

struct AppData {
    static var currentForecast: Forecast = Forecast(cod: "", message: 0, cnt: 0, list: [], city: City(id: 0, name: "", coord: Coord(lat: 0.0, lon: 0.0), country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
}
