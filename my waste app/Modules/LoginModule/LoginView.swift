//
//  LoginView.swift
//  my waste app
//
//  Created by Mark Golubev on 28/07/2023.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("red")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 150)
                Text("Simply login with your Apple id\nto save your bins. We don't store your personal data.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    //
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 250,height: 44)
                        HStack {
                            Image(systemName: "apple.logo")
                            Text("Sign in with Apple")
                        }
                        .foregroundColor(.black)
                    }
                }
                Spacer()

                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
