//
//  NotificationBageView.swift
//  my waste app
//
//  Created by Mark Golubev on 09/11/2023.
//

import SwiftUI

struct NotificationBageView: View {
    var didTapClose: () -> ()
    
    var body: some View {
        Button {
            didTapClose()
            
            Task {
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                    await UIApplication.shared.open(url)
                }
                
            }
        } label: {
            HStack(alignment: .top) {
                Image(systemName: "bell.badge.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.all, 4)
                    .background(Color("primary_elements"))
                    .cornerRadius(10.0)
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Enable push notifications")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("The app will let you know when it’s time to take out the bins.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(.all, 20)
            .background(Color("primary_cell"))
            .cornerRadius(10.0)


        }
//        .padding(.vertical)
        .padding(.horizontal, 20)
    }
}
