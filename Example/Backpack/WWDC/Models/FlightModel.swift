//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

struct FlightModel: Identifiable {
    let id: UUID
    
    let airline: String
    let legs: [FlightLegModel]
    let price: String
    var isAddedToFavorites: Bool
    
    init(id: UUID = UUID(), airline: String, legs: [FlightLegModel], price: String, isAddedToFavorites: Bool = false) {
        self.id = id
        self.airline = airline
        self.legs = legs
        self.price = price
        self.isAddedToFavorites = isAddedToFavorites
    }
}

struct FlightLegModel: Identifiable {
    let id: UUID
    let departureTime: String
    let returnTime: String
    
    let outboundAirport: String
    let returnAirport: String
    
    let flightTime: Int
    let stops: String
    let legType: String
    
    init(
        id: UUID = UUID(),
        departureTime: String,
        returnTime: String,
        outboundAirport: String,
        returnAirport: String,
        flightTime: Int,
        stops: String,
        legType: String
    ) {
        self.id = id
        self.departureTime = departureTime
        self.returnTime = returnTime
        self.outboundAirport = outboundAirport
        self.returnAirport = returnAirport
        self.flightTime = flightTime * 60
        self.stops = stops
        self.legType = legType
    }
    
    func convertSecondsToHrMinuteSec(seconds: Int, unitsStyle: DateComponentsFormatter.UnitsStyle = .full) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = unitsStyle
    
        let formattedString = formatter.string(from: TimeInterval(seconds))!
        return formattedString
    }
    
    var displayDuration: String {
        convertSecondsToHrMinuteSec(seconds: flightTime, unitsStyle: .abbreviated)
    }
    
    var a11yDuration: String {
        convertSecondsToHrMinuteSec(seconds: flightTime, unitsStyle: .full)
    }
}

extension FlightLegModel {
    enum LegType {
        case outbound, `return`
        
        var screenReaderCopy: String {
            switch self {
            case .outbound:
                "Outbound"
            case .return:
                "Return"
            }
        }
    }
}

// Example Data
extension FlightModel {
    static var exampleData: [FlightModel] = [
        FlightModel(
            airline: "Air Backpack",
            legs: [
                FlightLegModel(
                    departureTime: "19:50",
                    returnTime: "22:45",
                    outboundAirport: "LHR",
                    returnAirport: "SIN",
                    flightTime: 475,
                    stops: "Direct",
                    legType: "Outbound"
                ),
                FlightLegModel(
                    departureTime: "19:50",
                    returnTime: "22:45",
                    outboundAirport: "SIN",
                    returnAirport: "LHR",
                    flightTime: 475,
                    stops: "Direct",
                    legType: "Return"
                )
            ],
            price: "$650"
        ),
        FlightModel(
            airline: "Sky Airlines",
            legs: [
                FlightLegModel(
                    departureTime: "18:50",
                    returnTime: "21:45",
                    outboundAirport: "LHR",
                    returnAirport: "SIN",
                    flightTime: 475,
                    stops: "Direct",
                    legType: "Outbound"
                ),
                FlightLegModel(
                    departureTime: "18:50",
                    returnTime: "21:45",
                    outboundAirport: "SIN",
                    returnAirport: "LHR",
                    flightTime: 475,
                    stops: "Direct",
                    legType: "Return"
                )
            ],
            price: "$759"
        )
    ]
}
