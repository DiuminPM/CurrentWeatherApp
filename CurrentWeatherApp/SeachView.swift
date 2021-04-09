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
    
    var body: some View {
        VStack {
            SearschContentView(search: $search)
            LabelCurrentCity(toggleValue: $toggleValue)
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
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("textColor"))
                .padding(5)
            TextField("search city", text: $search)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("textColor"))
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 50, alignment: .center)
        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .cornerRadius(10)
        .shadow(color: Color(.black).opacity(0.6), radius: 4, x: 3, y: 3)
        
    }
}

struct LabelCurrentCity: View {
    @Binding var toggleValue: Bool
    var body: some View {
        VStack{
            Text("Stuttgard")
                .font(.system(size: 36))
                .foregroundColor(.black)
            HStack{
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
                
            }
        }
        
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
