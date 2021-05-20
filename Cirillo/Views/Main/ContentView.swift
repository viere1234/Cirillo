//
//  MainView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/2/11.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var selected = 0
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarColor")
        UITabBar.appearance().barTintColor = UIColor(named: "TabBarColor")
    }
    
    var body: some View {
        ZStack {
            Color("BackGround")
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                TimerView().tabItem {
                    Label(
                        title: { Text("Timer") },
                        icon: { Image(systemName: "stopwatch\(selected == 0 ? ".fill" : "")") }
                    )
                }.tag(0)
                .onAppear(perform: {
                    selected = 0
                })
                
                ProjectView().tabItem {
                    Label(
                        title: { Text("Tasks") },
                        icon: { Image(systemName: "square.stack.3d.down.forward\(selected == 1 ? ".fill" : "")") }
                    )
                }.tag(1)
                .onAppear(perform: {
                    selected = 1
                })
                
                StatusView().tabItem {
                    Label(
                        title: { Text("Statistics") },
                        icon: { Image(systemName: "chart.pie\(selected == 2 ? ".fill" : "")") }
                    )
                }.tag(2)
                .onAppear(perform: {
                    selected = 2
                })
                
                SettingView().tabItem {
                    Label(
                        title: { Text("Settings") },
                        icon: { Image(systemName: "gearshape\(selected == 3 ? ".fill" : "")") }
                    )
                }.tag(3)
                .onAppear(perform: {
                    selected = 3
                })
            }
            .accentColor(.white)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}
