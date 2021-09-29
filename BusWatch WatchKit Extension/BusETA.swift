//
//  BusETA.swift
//  BusWatch WatchKit Extension
//
//  Created by Jason Chow on 29/9/2021.
//

import Foundation

struct BusETA: Codable {
    var generated_timestamp: String?
    var data: [BusStopETA]
    
    struct BusStopETA: Codable {
        var route: String?
        var dir: String?
        var seq: Int?
        var dest_tc: String?
        var eta_seq: Int?
        var eta: String
    }
}
