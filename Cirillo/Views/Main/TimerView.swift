//
//  ContentView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/2/11.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    
    @AppStorage("NotificationActivated") var notificationActivated = true
    @AppStorage("HapticActivated") var hapticActivated = true
    @AppStorage("AutoRunActivated") var autoRunActivated = false
    @AppStorage("BreakTimeActivated") var breakTimeActivated = true
    @State private var timeRemaining = 1500
    @State private var status = 1
    @State private var timeCounter = 0
    @State private var breakTime = false
    @State private var startTime = Int(Date().timeIntervalSinceReferenceDate)
    @State private var activate = false
    @StateObject var delegate = NotificationDelegate()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let time = Date()
    var timeTotal = 1500
    
    init() {
        NotificationCenter.default.addObserverㄖ(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BackGround")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(Date(), style: .time)
                        .font(.system(size: geometry.size.width * 0.08454, weight: .light, design: .rounded))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    
                    Spacer()
                    
                    CountDownRingView(timeRemaining: self.timeRemaining,
                                      status: self.status,
                                      timeCounter: self.timeCounter,
                                      breakTime: self.breakTime,
                                      startTime: self.startTime,
                                      width: CGFloat(geometry.size.width),
                                      height: CGFloat(geometry.size.height))
                    
                    Spacer()
                    
                    ButtonControlView(status: self.$status,
                                      timeRemaining: self.$timeRemaining,
                                      timeCounter: self.$timeCounter,
                                      breakTime: self.$breakTime,
                                      startTime: self.$startTime,
                                      activate: self.$activate,
                                      notificationActivated: self.$notificationActivated,
                                      hapticActivated: self.$hapticActivated)
                        .padding(.bottom, 2)
                }
            }
            .onAppear(perform: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in }
                UNUserNotificationCenter.current().delegate = delegate
            })
            .onReceive(self.timer, perform: { time in
                if activate {
                    self.timeRemaining -= Int(Date().timeIntervalSinceReferenceDate) - startTime
                    self.startTime = Int(Date().timeIntervalSinceReferenceDate)
                }
                switch self.status {
                    case 1, 3, 5:
                        break
                    default:
                        if self.timeRemaining < 0 {
                            self.activate = false
                            if self.status == 2 && self.breakTime {
                                self.status = 5
                                self.timeCounter += 1
                                self.timeRemaining = timeCounter == 4 ? 1200 : 300
                                self.breakTime = true
                            } else if self.status == 6 {
                                self.status = 1
                                self.timeRemaining = 1500
                                self.breakTime = false
                                if self.timeCounter == 4 {
                                    self.timeCounter = 0
                                }
                            }
                        }
                }
            })
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}

struct CountDownRingView: View {
    
    let timeRemaining: Int
    let status: Int
    let timeCounter: Int
    let breakTime: Bool
    let startTime: Int
    let timeData = Date()
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        
        let progress = CGFloat(timeRemaining) / CGFloat(status == 5 || status == 6 ? timeCounter == 4 ? 900 : 300 : 1500)
        
        ZStack {
            Circle()
                .foregroundColor(Color("BackGround"))
                .frame(width: width * 0.86956, height: width * 0.86956)
                .shadow(color:Color(.white).opacity(0.1), radius: 20)
            
            Circle()
                .stroke(!breakTime ? Color("WorkCircle") : Color("BreakCircle"),
                        style: StrokeStyle(lineWidth: 10))
                .frame(width: width * 0.797101, height: width * 0.797101)
            
            Circle()
                .trim(from: progress, to: 1)
                .stroke(!breakTime ? Color("ActiveButton") : Color("BreakButton"),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width * 0.797101, height: width * 0.797101)
                .shadow(color: Color("ActiveButton").opacity(0.1), radius: 3, x: 0, y: 3)
                .animation(.easeInOut)
            
            Text("\(timeRemaining/60):\(timeRemaining%60, specifier: "%02d")")
                .font(.custom("Monaco", size: 75))
                .kerning(3)
                .foregroundColor(.white)
                .frame(width: width * 0.84541, height: height * 0.06501)
        }
    }
}

struct ButtonControlView: View {
    
    @Binding var status: Int
    @Binding var timeRemaining : Int
    @Binding var timeCounter: Int
    @Binding var breakTime: Bool
    @Binding var startTime: Int
    @Binding var activate: Bool
    @Binding var notificationActivated: Bool
    @Binding var hapticActivated: Bool
    let generrator = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack {
            switch status {
                case 2:
                    Button (action: {
                        if notificationActivated { UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["BreakTimer"]) }
                        if hapticActivated { generrator.notificationOccurred(.warning) }
                        status = 3
                        activate = false
                    }, label: {
                        Text("Pause")
                            .kerning(1)
                            .frame(width: 350, height: 45)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                            .background(Color("ActiveButton"))
                            .cornerRadius(10)
                    })
                case 3:
                    HStack {
                        Button(action: {
                            if notificationActivated { UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["BreakTimer"]) }
                            if hapticActivated { generrator.notificationOccurred(.error) }
                            status = 1
                            timeRemaining = 1500
                            timeCounter = 0
                        }, label: {
                            Text("Stop")
                                .kerning(1)
                                .frame(width: 160, height: 45)
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .foregroundColor(Color("ActiveButton"))
                                .background(Color("DeActiveButton"))
                                .cornerRadius(10)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            if notificationActivated { Notify(title: "Times up", body: "Time to take a break", time: Double(timeRemaining), id: "BreakTimer") }
                            if hapticActivated { generrator.notificationOccurred(.success) }
                            status = 2
                            activate = true
                            startTime = Int(Date().timeIntervalSinceReferenceDate)
                        }, label: {
                            Text("Continue")
                                .kerning(1)
                                .frame(width: 160, height: 45)
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .foregroundColor(.white)
                                .background(Color("ActiveButton"))
                                .cornerRadius(10)
                        })
                    } .frame(width: 350, height: 45)
                case 5:
                    Button (action: {
                        if notificationActivated { Notify(title: "Times up", body: "Time to keep working", time: Double(timeRemaining), id: "WorkingTimer") }
                        if hapticActivated { generrator.notificationOccurred(.success) }
                        status = 6
                        activate = true
                        startTime = Int(Date().timeIntervalSinceReferenceDate)
                    }, label: {
                        Text("Break Time")
                            .kerning(1)
                            .frame(width: 350, height: 45)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                            .background(Color("BreakButton"))
                            .cornerRadius(10)
                    })
                case 6:
                    Button (action: {
                        if notificationActivated { UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["WorkingTimer"]) }
                        if hapticActivated { generrator.notificationOccurred(.warning) }
                        status = 1
                        timeRemaining = 1500
                        breakTime = false
                        if timeCounter == 4 {
                            timeCounter = 0
                        }
                        activate = false
                    }, label: {
                        Text("Skip Break")
                            .kerning(1)
                            .frame(width: 350, height: 45)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                            .background(Color("BreakButton"))
                            .cornerRadius(10)
                    })
                default:
                    Button (action: {
                        if notificationActivated { Notify(title: "Times up", body: "Time to take a break", time: Double(timeRemaining), id: "BreakTimer") }
                        if hapticActivated { generrator.notificationOccurred(.success) }
                        startTime = Int(Date().timeIntervalSinceReferenceDate)
                        status = 2
                        activate = true
                    }, label: {
                        Text("Start")
                            .kerning(1)
                            .frame(width: 350, height: 45)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                            .background(Color("ActiveButton"))
                            .cornerRadius(10)
                    })
            }
        }
        .animation(.default)
        .padding(.bottom, 5)
    }
}

func Notify(title: String, body: String, time: Double, id: String) {
    
    let content = UNMutableNotificationContent()
    
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .banner, .sound])
    }
}
