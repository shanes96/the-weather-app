//
//  ContentView.swift
//  Shane Weather App
//
//  Created by Shane Standifur on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                    if let weather = weather {
                       WeatherView(weather: weather)
                    } else {
                        LoadingView()
                            .task{
                                do {
                                    weather = try await
                                        weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print ("Error getting weather: \(error)")
                                }
                            }
                    }
                

            } else {
                    if locationManager.isLoading{
                        LoadingView()
                    }else{
                        WelcomeView ()
                            .environmentObject(locationManager)
                    }
                }
            }
           
        .background(Color(hue: 0.686, saturation: 0.898, brightness: 0.4))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
