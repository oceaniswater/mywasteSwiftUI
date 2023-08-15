//
//  NotificationScreenView.swift
//  my waste app
//
//  Created by Mark Golubev on 28/07/2023.
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var nm = NotificationManager()
    @Binding var showNotificationView: Bool
    @State var isRotating = false

    
    
    var body: some View {
        NavigationView {
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
                    Text("Turn on your push notificatons\nto do not miss collection day. You can do it later in settings.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button {
                        Task {
                            await nm.request()
                            showNotificationView = false
                            UserDefaults.standard.setValue(true, forKey: "notFirstTime")
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(width: 250,height: 44)
                            HStack {
                                Image(systemName: "bell")
                                Text("Turn on notification")
                            }
                            .foregroundColor(.black)
                        }
                    }
                    Button {
                        showNotificationView = false
                        UserDefaults.standard.setValue(true, forKey: "notFirstTime")
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .cornerRadius(10)
                                .frame(width: 250,height: 44)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.white, lineWidth: 1)
                                    )

                            Text("Later")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .task {
                    await nm.getAuthStatus()
                }
            }
        }
    }
}

struct NotificationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(showNotificationView: .constant(true))
    }
}
