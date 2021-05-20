//
//  SettingView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/2/11.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("NotificationActivated") var notificationActivated = true
    @AppStorage("DeveloperActivated") var developerActivated = false
    @AppStorage("HapticActivated") var hapticActivated = true
    @State private var developerCounter = 0
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color("BackGround")
                    .edgesIgnoringSafeArea(.all)
                
                NavigationView {
                    Form {
                        Section (header: Text("General").foregroundColor(.white).padding(.top, 20)) {
                            NavigationLink(destination: TimerSetView()) {
                                Label(
                                    title: { Text("Timer Settings") },
                                    icon: { Image(systemName: "slider.horizontal.3") }
                                )
                            }
                            
                            Toggle(isOn: $notificationActivated) {
                                Label(
                                    title: { Text("Notification") },
                                    icon: { Image(systemName: "bell.badge") }
                                )
                            }
                            
                            Toggle(isOn: $hapticActivated) {
                                Label(
                                    title: { Text("Core Haptics") },
                                    icon: { Image(systemName: "hand.tap") }
                                )
                            }
                        }
                        .listRowBackground(Color("TabBarColor"))
                        .foregroundColor(.white)
                        
                        Section (header: Text("Apperance").foregroundColor(.white)) {
                            NavigationLink(destination: AppIconSetView()) {
                                Label(
                                    title: { Text("App Icon") },
                                    icon: { Image(systemName: "paintbrush") }
                                )
                            }
                            NavigationLink(destination: ThemeSetView()) {
                                Label(
                                    title: { Text("Theme") },
                                    icon: { Image(systemName: "paintpalette") }
                                )
                            }
                            NavigationLink(destination: TimerThemeSetView()) {
                                Label(
                                    title: { Text("Timer") },
                                    icon: { Image(systemName: "paintbrush.pointed") }
                                )
                            }
                        }
                        .listRowBackground(Color("TabBarColor"))
                        .foregroundColor(.white)
                        
                        Section (header: Text("Support").foregroundColor(.white)) {
                            NavigationLink(destination: SupportView()) {
                                Label(
                                    title: { Text("Support") },
                                    icon: { Image(systemName: "person.fill.questionmark") }
                                )
                            }
                            NavigationLink(destination: TestingView()) {
                                Label(
                                    title: { Text("Sent Feedback") },
                                    icon: { Image(systemName: "paperplane") }
                                )
                            }
                        }
                        .listRowBackground(Color("TabBarColor"))
                        .foregroundColor(.white)
                        
                        Section (header: Text("Cirillo").foregroundColor(.white)) {
                            NavigationLink(destination: TestingView()) {
                                Label(
                                    title: { Text("Rate This App") },
                                    icon: { Image(systemName: "star.fill") }
                                )
                            }
                            NavigationLink(destination: TestingView()) {
                                Label(
                                    title: { Text("Share With Friends") },
                                    icon: { Image(systemName: "square.and.arrow.up.on.square") }
                                )
                            }
                            NavigationLink(destination: AboutView()) {
                                Label(
                                    title: { Text("About Us") },
                                    icon: { Image(systemName: "crown.fill") }
                                )
                            }
                        }
                        .listRowBackground(Color("TabBarColor"))
                        .foregroundColor(.white)
                        
                        if developerActivated {
                            Section (header: Text("Developer")) {
                                NavigationLink(destination: DeveloperView()) {
                                    Label(
                                        title: { Text("Developer Options") },
                                        icon: { Image(systemName: "hammer") }
                                    )
                                }
                            }
                            .listRowBackground(Color("TabBarColor"))
                            .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            self.developerCounter += 1
                            if developerCounter == 10 {
                                developerCounter = 0
                                developerActivated.toggle()
                            }
                        }, label: {
                            HStack {
                                Spacer()
                                
                                Text("Cirillo for Mobile Version Beta 0.2.1 (1)")
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        })
                        .listRowBackground(Color("BackGround"))
                    }
                    .background(Color("BackGround"))
                    .navigationBarTitle("Settings", displayMode: .automatic)
                }
                .navigationBarColor(backgroundColor: UIColor(Color("BackGround")), tintColor: .white)
            }
        }
        .onDisappear(perform: {
            self.developerCounter = 0
        })
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
