//
//  SeachView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI
import CoreLocation
import CoreData
import SwiftUICharts

struct SeachView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @Binding var toggleValue: Bool
    @Binding var currentCity: String
    @Binding var currentTemperature: Double
    @Binding var isPresenter: Bool
    @State var shouldHide = false
    @Binding var countWeatherList: Int

    
    var body: some View {
        VStack() {
            SearschContentView(search: $addWeatherVM.city, city: $currentCity, temperature: $currentTemperature)
            LabelCurrentCity(toggleUnitsValue: $toggleValue, currentCity: currentCity, currentTemperature: $currentTemperature)
            List {ForEach(SearchViewModel.unicalyWeatherList, id: \.id)  { weather in
                    HStack{
                        Cell(toggleValue: $toggleValue, weather: weather.weatherCore[0], countWeatherList: $countWeatherList)
                        Spacer()
                        if !self.$shouldHide.wrappedValue {
                            Button(action: {
                                searchViewModel.addCityWheater(currentCity: weather.city)
                                isPresenter.toggle()
                                SearchViewModel.temperaturesForCharts = []
                                searchViewModel.addTemperaturesForChart()
                                print(SearchViewModel.temperaturesForCharts)
                            }) { Image(systemName: "doc.text.magnifyingglass") }
                        }
                    }
                    .onAppear{
//                        if weather.weatherCore.count > 1 { shouldHide = false }   // ??? Боролся со скрытием кнопки долго и упорно
//                        else {shouldHide = true}
                        
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear{
                searchViewModel.makedCityList()
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
                .padding(10)
            TextField("City name", text: $addWeatherVM.city)
            {isEditing in
                self.isEditing = isEditing}
            onCommit: {
                addWeatherVM.save { (weather) in
                    self.temperature = weather.temperature
                    self.city = weather.city
                    searchViewModel.saveWeatherCore(with: weather.city, with: weather.temperature, with: CurrentData.dateFormatter())
                    addWeatherVM.city = ""
                }
            }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        }
        .frame(height: 40, alignment: .center)
        .background(Color(#colorLiteral(red: 0.02182334103, green: 0.005694539752, blue: 0.02355073579, alpha: 0.07800747701)))
        .cornerRadius(10)
        .padding()
        }
    }
}

struct LabelCurrentCity: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @Binding var toggleUnitsValue: Bool
    var currentCity: String
    @Binding var currentTemperature: Double
    var body: some View {
        VStack{
            HStack {
                Text("\(currentCity)")
                    .font(.system(size: 36))
                    .foregroundColor(.black)
                Spacer()
            } .padding()
            HStack (alignment: .center){
                
                Toggle(isOn: $toggleUnitsValue) {
                    HStack{
                        Text("\(addWeatherVM.switchUnits(temperature: currentTemperature, toggleValue: toggleUnitsValue))")
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
        .background(Color(addWeatherVM.colorCurrentContent(temperature: currentTemperature, toggleValue: toggleUnitsValue)))
        
    }
}

struct DetailWeatherCityView: View {
    @StateObject var searchViewModel = SearchViewModel()
    @Binding var toggleUnitsTemp: Bool
    @Binding var isPresenter: Bool
    @Binding var countWeatherList: Int
    var tempCityList: [Double] = []
    
    var body: some View {
        VStack() {
            LineView(data: SearchViewModel.temperaturesForCharts)
                .padding()
            List {ForEach(SearchViewModel.cityWeathers, id: \.id)  { weather in
                DetailCell(toggleValue: $toggleUnitsTemp, weather: weather)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear{
            countWeatherList = SearchViewModel.cityWeathers.count
//            searchViewModel.addTemperaturesForChart()
//            print(tempCityList)
        }
    }
}

struct Cell: View {
    @Binding var toggleValue: Bool
    @StateObject var addWeatherVM = AddWeatherViewModel()
    let weather: WeatherCore
    @Binding var countWeatherList: Int

    
    var body: some View {
        HStack{
            VStack (alignment: .leading, spacing: 8){
                Text("\(weather.city!), \(addWeatherVM.switchUnits(temperature: weather.temperature, toggleValue: toggleValue))")
                Text("\(weather.date!)")
                }
        }
        .onAppear{
            
        }
    }

}

struct DetailCell: View {
    @Binding var toggleValue: Bool
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    let weather: WeatherCore
    
    var body: some View {
            VStack (alignment: .leading, spacing: 8){
                Text("\(weather.city!), \(addWeatherVM.switchUnits(temperature: weather.temperature, toggleValue: toggleValue))")
                Text("\(weather.date!)")
                }
    }

}

struct ToolBarButton: View {
    @Binding var currentCity: String
    @Binding var temperature: Double
    @StateObject var locationView = LocationViewModel()
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    var body: some View {
        Button(action: {
            addWeatherVM.saveByCoordinates(coordinates: Coordinates(latitude: locationView.userLatitude, longitude: locationView.userLongitude)) { (weather) in
                searchViewModel.saveWeatherCore(with: weather.city, with: weather.temperature, with: CurrentData.dateFormatter())
                self.temperature = weather.temperature
                self.currentCity = weather.city
            }
        })
        { Image(systemName: "location.circle") }
    }

}

