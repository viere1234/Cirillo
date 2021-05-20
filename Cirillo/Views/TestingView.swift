//
//  TestingView.swift
//  Cirillo
//
//  Created by 張智堯 on 2021/3/6.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        ZStack{
            Color("BackGround")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("This is a testing view")
                .foregroundColor(.white)
                .navigationBarTitle("Testing", displayMode: .automatic)
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
