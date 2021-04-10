//
//  ContentView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            NavigationView {
                
                VStack {
                    SeachView()
                    
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
                               Button(action: {}) {
                                   Image(systemName: "location.circle")
                                }
                       }
               }
            }
        }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
