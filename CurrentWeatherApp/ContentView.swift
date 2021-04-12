//
//  ContentView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @State var toggleValue: Bool = false
    @State var currentCity: String = "Stuttgard"
    @State var currentTemperature: Double = 0
    
    var body: some View {
            NavigationView {
                
                VStack {
                    SeachView(toggleValue: $toggleValue, currentCity: $currentCity, currentTemperature: $currentTemperature)
                    
                }
                .multilineTextAlignment(.leading)
                .navigationBarTitle(Text("Weather"), displayMode: .inline)
                .onAppear(perform: {
                    UINavigationBar.appearance().standardAppearance.shadowColor = .clear
//                    newAppearance.configureWithOpaqueBackground()
//                    newAppearance.backgroundColor = .white
                })
                .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                        ToolBarButton(city: $currentCity, temperature: $currentTemperature)
                       }
               }
            }
        }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SearchViewModel())
    }
}
