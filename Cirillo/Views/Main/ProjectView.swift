//
//  ProjectView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/2/11.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color("BackGround")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Text("We are working on it")
                    .foregroundColor(.white)
                    .navigationBarTitle("Tasks", displayMode: .automatic)
            }
        }
        .navigationBarColor(backgroundColor: UIColor(Color("BackGround")), tintColor: .white)
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
