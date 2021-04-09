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
                    .multilineTextAlignment(.leading)
                    
                    .navigationBarTitle(Text("Weather"), displayMode: .inline)
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {}) {
                                    Image(systemName: "location.circle")
                            }
                        }
                }
                Spacer()
            }
                
            
        }
        }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
