//
//  LoginView.swift
//  my waste app
//
//  Created by Mark Golubev on 28/07/2023.
//

import SwiftUI


struct LoginView: View {
    @Binding var showLoginScreen: Bool
    @Binding var showNotificationView: Bool
    @StateObject var vm = AuthViewModel()
    @State var isRotating = false
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack {
                    Image("red")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 150)
                    Image("recycle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 55)
                        .offset(y: 10)
                }
                .rotationEffect(.degrees(isRotating ? 30.0 : 0.0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        self.isRotating = true
                    }
                }
                Text("Simply login with your Apple id\nto save your bins. We don't store your personal data.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    //                        UserDefaults.standard.set("test1", forKey: "userId")
                    Task {
                        do {
                            try await vm.signInApple()
                            showLoginScreen = false
                            showNotificationView = true
                        } catch {
                            
                        }
                    }
                } label: {
                    SignInWithAppleButtonViewRepresentable(type: .signIn, style: .white)
                        .allowsTightening(false)
                        .frame(width: 250,height: 44)
                }
                Spacer()

            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLoginScreen: .constant(true), showNotificationView: .constant(false))
    }
}
