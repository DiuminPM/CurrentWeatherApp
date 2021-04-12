//
//  SeachView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI
import CoreLocation

struct SeachView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @Binding var toggleValue: Bool
    @Binding var currentCity: String
    @Binding var currentTemperature: Double
//    @StateObject var searchViewModel = SearchViewModel()
//
//    @ObservedObject var dataWeather = SearchViewModel()
//

//    var currentCity = "Stuttgard"
   
    
    
    
    
    var body: some View {
        VStack() {
            SearschContentView(search: $addWeatherVM.city, city: $currentCity, temperature: $currentTemperature)
            LabelCurrentCity(toggleValue: $toggleValue, currentCity: currentCity, currentTemperature: addWeatherVM.switchUnits(temperature: currentTemperature, toggleValue: toggleValue))
            List {ForEach(SearchViewModel.weathers, id: \.id)  { weather in
                Cell(weather: weather)
                }
            }
            .listStyle(PlainListStyle())
    }
}


struct SearschContentView: View {
    @Binding var search: String
    @Binding var city: String
    @Binding var temperature: Double
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @State private var isEditing = true
    var body: some View {
        HStack() {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .padding(15)
            TextField("search city", text: $addWeatherVM.city)
            {isEditing in
                self.isEditing = isEditing}
            onCommit: {
                addWeatherVM.save { (weather) in
                    self.temperature = weather.temperature
                    self.city = weather.city
                    searchViewModel.addWeather(weather)
                    addWeatherVM.city = ""
                }
//                searchViewModel.fetchWeathers()
            }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        }
        .frame(height: 40, alignment: .center)
        .background(Color(#colorLiteral(red: 0.02182334103, green: 0.005694539752, blue: 0.02355073579, alpha: 0.07800747701)))
        .cornerRadius(10)
//        .shadow(color: Color(.black).opacity(0.6), radius: 4, x: 3, y: 3)
        .padding()
        }
    }
}

struct LabelCurrentCity: View {
    @Binding var toggleValue: Bool
    var currentCity: String
    var currentTemperature: Double
    @StateObject var addWeatherVM = AddWeatherViewModel()
    var body: some View {
        VStack{
            HStack {
                Text("\(currentCity)")
                    .font(.system(size: 36))
                    .foregroundColor(.black)
                Spacer()
            } .padding()
            HStack (alignment: .center){
                
                Toggle(isOn: $toggleValue) {
                    HStack{
                        Text("\(Int(currentTemperature))˚")
                            .font(.system(size: 26))
                            .foregroundColor(.black)
                        Spacer()
                        Text("F")
                            .font(.system(size: 26))
                            .foregroundColor(.black)
                    }
                }
                Text("C")
                    .font(.system(size: 26))
                    .foregroundColor(.black)
                
            } .padding()
        }
        .frame(height: 150)
        .background(Color(addWeatherVM.colorCurrentContent(temperature: currentTemperature, toggleValue: toggleValue)))
        
    }
}

struct Cell: View {
//    @Binding var currentCity: String
//    @Binding var temperature: Int
    let weather: WeatherViewModel
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text("\(weather.city), \(Int(weather.temperature))˚F")
                Text("\(CurrentData.dateFormatter())")
            }
    }

}

struct ToolBarButton: View {
//    @Binding var currentCity: String
//    @Binding var temperature: Int
    @StateObject var locationView = LocationViewModel()
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @Binding var city: String
    @Binding var temperature: Double
    var body: some View {
        Button(action: {
            addWeatherVM.saveByCoordinates(coordinates: Coordinates(latitude: locationView.userLatitude, longitude: locationView.userLongitude)) { (weather) in
                self.temperature = weather.temperature
                self.city = weather.city
                searchViewModel.addWeather(weather)
            }
            print("проверка \(locationView.userLatitude)")
        }) {
                   Image(systemName: "location.circle")
                }
    }

}

