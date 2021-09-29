//
//  ContentView.swift
//  BusWatch WatchKit Extension
//
//  Created by Jason Chow on 29/9/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = ContentViewController()
    
    var body: some View {
        VStack {
            HStack {
                Text(controller.bus.route)
                    .font(.title)
                    .foregroundColor(Color.init(red: 1.0, green: 0.4, blue: 0.4))
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("往")
                    .font(.subheadline)
                    .foregroundColor(Color.accentColor)
                    .multilineTextAlignment(.leading)
                Text(controller.bus.dest)
                    .font(.subheadline)
                    .foregroundColor(Color.accentColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(width: 60.0)
            }
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Text(controller.bus.busTime[0])
                    .font(Font.custom("", fixedSize: 60.0))
                Text("Min(s)")
            }
            
            HStack {
                Text("Next：")
                Text(controller.bus.busTime[1])
                Text("/")
                Text(controller.bus.busTime[2])
                Text("Min(s)")
            }
            .padding(.top, 2.0)
            
            Spacer()
            
            HStack {
                Text("\(controller.lastUpdateTime)")
                    .font(.subheadline)
                    .foregroundColor(Color.accentColor)
                    .multilineTextAlignment(.leading)
                .lineLimit(1)
                
                Text("sec(s) Before")
                    .font(.subheadline)
                    .foregroundColor(Color.accentColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
