//
//  DeveloperView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/3/12.
//

import SwiftUI

struct DeveloperView: View {
    var body: some View {
        ZStack{
            Color("BackGround")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("I'm glad you found here\nBut we are still working on it")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .navigationBarTitle("Developer Options", displayMode: .automatic)
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
