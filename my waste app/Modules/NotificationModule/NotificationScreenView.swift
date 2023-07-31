//
//  NotificationScreenView.swift
//  my waste app
//
//  Created by Mark Golubev on 28/07/2023.
//

import SwiftUI

struct NotificationScreenView: View {
//    @State private var showMainScreen = false
    @Binding var showNotificationView: Bool
//    let binsListViewModel = BinsListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("yellow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 150)
                    Text("Turn on your push notificatons\nto do not miss collection day. You can do it later in settings.")
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
                                Image(systemName: "bell")
                                Text("Turn on notification")
                            }
                            .foregroundColor(.black)
                        }
                    }
                    Button {
                        withAnimation {
                            showNotificationView = false
                        }
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
//                .overlay(
//                    Group {
//                        if showMainScreen {
//                            ContentView()
//                                .environmentObject(binsListViewModel)
//                                .transition(.move(edge: .top))
//                        }
//                    }
//                )
            }
        }
    }
}

struct NotificationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreenView(showNotificationView: .constant(true))
    }
}
