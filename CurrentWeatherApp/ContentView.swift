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
            
            SeachView()
                .multilineTextAlignment(.center)
                .padding()
                .navigationBarTitle(Text("Weather"), displayMode: .inline)
                
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
