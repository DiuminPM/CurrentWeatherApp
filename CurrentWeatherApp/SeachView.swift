//
//  SeachView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI

struct SeachView: View {
    @State var search = ""
    @State var toggleValue: Bool = false
    var currentCity = "Stuttgard"
    var city = "Petrozavodsk"
    var temperature = "0"
    
    var body: some View {
        VStack() {
            SearschContentView(search: $search)
            LabelCurrentCity(toggleValue: $toggleValue, currentCity: currentCity)
            List(0..<100) { rowIndex in
                VStack (alignment: .leading, spacing: 8){
                        Text("\(city), \(temperature)˚F")
                        Text("\(CurrentData.dateFormatter())")
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct SeachView_Previews: PreviewProvider {
    static var previews: some View {
        SeachView()
    }
}

struct SearschContentView: View {
    @Binding var search: String
    var body: some View {
        HStack() {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .padding(15)
            TextField("search city", text: $search)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("textColor"))
        }
        .frame(height: 40, alignment: .center)
        .background(Color(#colorLiteral(red: 0.02182334103, green: 0.005694539752, blue: 0.02355073579, alpha: 0.07800747701)))
        .cornerRadius(10)
//        .shadow(color: Color(.black).opacity(0.6), radius: 4, x: 3, y: 3)
        .padding()
        
    }
}

struct LabelCurrentCity: View {
    @Binding var toggleValue: Bool
    var currentCity: String
    var body: some View {
        VStack{
            HStack {
                Text("\(currentCity)")
                    .font(.system(size: 36))
                    .foregroundColor(.black)
                Spacer()
            } .padding()
            HStack (alignment: .center){
                Text("31˚")
                    .font(.system(size: 26))
                    .foregroundColor(.black)
                Spacer()
                Text("F")
                    .font(.system(size: 26))
                    .foregroundColor(.black)
                Toggle("", isOn: $toggleValue)
                Text("C")
                    .font(.system(size: 26))
                    .foregroundColor(.black)
                
            } .padding()
        }
        .frame(height: 150)
        .background(Color(#colorLiteral(red: 0.07280416042, green: 0.7571062446, blue: 0.9571402669, alpha: 1)))
        
    }
}

//struct ToggleDegrees {
//    @Binding var toggleValue: Bool
//    var body: some View {
//        HStack{
//            Text("F")
//                .font(.system(size: 26))
//                .foregroundColor(.black)
//            Toggle("", isOn: $toggleValue)
//            Text("C")
//                .font(.system(size: 26))
//                .foregroundColor(.black)
//        }
//    }
//
//}
