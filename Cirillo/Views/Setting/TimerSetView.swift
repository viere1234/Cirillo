//
//  TimerSettingView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/3/12.
//

import SwiftUI

struct TimerSetView: View {
    
    @AppStorage("AutoRunActivated") var autoRunActivated = false
    @AppStorage("BreakTimeActivated") var breakTimeActivated = true
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            Color("BackGround")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Form {
                Section() {
                    Toggle(isOn: $autoRunActivated, label: {
                        Label(
                            title: { Text("Auto Run ( Not Support )") },
                            icon: { Image(systemName: "repeat") }
                        )
                    })
                    Toggle(isOn: $breakTimeActivated, label: {
                        Label(
                            title: { Text("Break Time") },
                            icon: { Image(systemName: "figure.walk") }
                        )
                    })
                }
                .listRowBackground(Color("TabBarColor"))
                .foregroundColor(.white)
            }
            .background(Color("BackGround"))
            .navigationTitle("Timer Setting")
        }
    }
}

struct TimerSetView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSetView()
    }
}
