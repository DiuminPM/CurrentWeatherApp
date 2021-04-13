//
//  SeachView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI
import CoreLocation
import CoreData

struct SeachView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @Binding var toggleValue: Bool
    @Binding var currentCity: String
    @Binding var currentTemperature: Double
    @Binding var isPresenter: Bool
    @State var shouldHide = true
    @State var cityWeathers = []
    
    var body: some View {
        VStack() {
            SearschContentView(search: $addWeatherVM.city, city: $currentCity, temperature: $currentTemperature)
            LabelCurrentCity(toggleValue: $toggleValue, currentCity: currentCity, currentTemperature: $currentTemperature)
            List {ForEach(SearchViewModel.weathersCore, id: \.id)  { weather in
                    HStack{
                        Cell(isPresenter: $isPresenter, toggleValue: $toggleValue, weather: weather)
                        Spacer()
                        if !self.$shouldHide.wrappedValue {
                            Button(action: {
                                searchViewModel.addCityWheater(currentCity: weather.city!)
                                print(SearchViewModel.cityWeathers)
                                isPresenter.toggle()
                            }) {
                                       Image(systemName: "doc.text.magnifyingglass")
                    
                                    }
                            }

                        }
                    .onAppear(perform: {
                        
                        self.cityWeathers = SearchViewModel.weathersCore.filter({ (cityWeather) -> Bool in
                            if  cityWeather.city == weather.city! {
                                return true
                            }
                            return false
                        })
                        print("проверка \(cityWeathers.count)")
                        if cityWeathers.count > 1 {
                            shouldHide = false
                        }
                        
                    })
                
                    }
                }
            .listStyle(PlainListStyle())
            
            .onAppear{
                
            }
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
                    searchViewModel.saveWeatherCore(with: weather.city, with: weather.temperature)
//                    searchViewModel.addWeather(weather)
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
    @Binding var currentTemperature: Double
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
                        Text("\(addWeatherVM.switchUnits(temperature: currentTemperature, toggleValue: toggleValue))")
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

struct DetailWeatherCityView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @Binding var toggleValue: Bool
    @Binding var currentCity: String
    @Binding var currentTemperature: Double
    @Binding var isPresenter: Bool
    
    var body: some View {
        VStack() {
            List {ForEach(SearchViewModel.cityWeathers, id: \.id)  { weather in
                DetailCell(isPresenter: $isPresenter, toggleValue: $toggleValue, weather: weather)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct Cell: View {
//    @Binding var currentCity: String
    @Binding var isPresenter: Bool
    @Binding var toggleValue: Bool
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    var cityWeathers: [WeatherCore] = []
    let weather: WeatherCore
    
    var body: some View {
        HStack{
            VStack (alignment: .leading, spacing: 8){
                Text("\(weather.city!), \(addWeatherVM.switchUnits(temperature: weather.temperature, toggleValue: toggleValue))")
                    Text("\(CurrentData.dateFormatter())")
                }
            
            
            
            
            
            
        }
    }

}

struct DetailCell: View {
//    @Binding var currentCity: String
    @Binding var isPresenter: Bool
    @Binding var toggleValue: Bool
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    var cityWeathers: [WeatherCore] = []
    let weather: WeatherCore
    
    var body: some View {
            VStack (alignment: .leading, spacing: 8){
                Text("\(weather.city!), \(addWeatherVM.switchUnits(temperature: weather.temperature, toggleValue: toggleValue))")
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
                searchViewModel.saveWeatherCore(with: weather.city, with: weather.temperature)
            }
            print("проверка \(locationView.userLatitude)")
        }) {
                   Image(systemName: "location.circle")
                }
    }

}

