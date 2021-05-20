//
//  ThemeSetView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/3/12.
//

import SwiftUI

struct ThemeSetView: View {
    var body: some View {
        ZStack{
            Color("BackGround")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("We are looking for art desiner\nIf you are intresting\nPlease contect us")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .navigationBarTitle("Theme", displayMode: .automatic)
        }
    }
}

struct ThemeSetView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSetView()
    }
}
