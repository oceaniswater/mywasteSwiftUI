//
//  NotificationScreenView.swift
//  my waste app
//
//  Created by Mark Golubev on 28/07/2023.
//

import SwiftUI

struct NotificationScreenView: View {
    var body: some View {
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
                    //
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
            
        }
    }
}

struct NotificationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreenView()
    }
}
