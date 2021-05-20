//
//  AboutView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/3/12.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack{
            Color("BackGround")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("We are working on it")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .navigationBarTitle("About Us", displayMode: .automatic)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
