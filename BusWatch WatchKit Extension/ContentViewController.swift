//
//  ContentViewController.swift
//  BusWatch WatchKit Extension
//
//  Created by Jason Chow on 29/9/2021.
//

import Foundation
import Alamofire

class ContentViewController: ObservableObject {
    
    @Published var bus: DisplayBus
    @Published var lastUpdateTime: Int
    
    var isDoneLastRequest = true
    
    init() {
        bus = DisplayBus(route: "--", dest: "---", busTime: ["--", "--", "--"])
        lastUpdateTime = 0
        
        getEta()
        
        Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { [self] timer in
            print("Timer fired!")
            getEta()
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            lastUpdateTime += 1
        }
    }
    
    func getEta() {
        guard isDoneLastRequest else {
            print("isDoneLastRequest = \(isDoneLastRequest)")
            return
        }
        isDoneLastRequest = false
        
        //init data
        
        var route = "--"
        var dest = "--"
        var busTime: [String] = []
        
        // get bus eta
        AF.request("https://data.etabus.gov.hk/v1/transport/kmb/route-eta/277E/1").response { [self] response in
            do {
                
                defer {
                    while(busTime.count < 3) {
                        busTime.append("--")
                    }
                    print(busTime)
                    bus = DisplayBus(route: route, dest: dest, busTime: busTime)
                    lastUpdateTime = 0
                    isDoneLastRequest = true
                }
                
                if let data = response.data {
                    let decodedData = try JSONDecoder().decode(BusETA.self, from: data)
                    if decodedData.data.count > 0, let generatedTime = decodedData.generated_timestamp {
                        for eta in decodedData.data {
                            if eta.seq == 4 && eta.dir == "I" {
                                route = eta.route ?? "--"
                                dest = eta.dest_tc ?? "--"
                                busTime.append(iSO8601ToMin(eta.eta, generatedTime))
                                
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func iSO8601ToMin(_ busTime: String, _ generatedTime: String) -> String {
        let formatter = ISO8601DateFormatter()
        let time = formatter.date(from: busTime)?.timeIntervalSince1970 ?? 0.0
        let generatedTime = formatter.date(from: generatedTime)?.timeIntervalSince1970 ?? 0.0
        print((time - generatedTime) / 60.0)
        return String(format: "%.0f", (time - generatedTime) / 60.0)
    }
}
