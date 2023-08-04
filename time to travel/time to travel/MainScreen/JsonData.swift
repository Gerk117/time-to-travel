//
//  JsonData.swift
//  time to travel
//
//  Created by Георгий Ксенодохов on 03.08.2023.
//

import Foundation

struct JsonData : Codable {
    var flights : [FlightsData]
}
struct FlightsData : Codable {
    var startDate : String
    var endDate : String
    var startLocationCode : String
    var endLocationCode : String
    var startCity : String
    var endCity : String
    var price : Int
}

