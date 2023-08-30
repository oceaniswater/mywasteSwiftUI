//
//  AlertView.swift
//  my waste app
//
//  Created by Mark Golubev on 21/08/2023.
//

import SwiftUI

struct AlertView: View {
    @Environment(\.dismiss) var dismiss
    
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                Button(action: didTapClose, label: {
                    
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(.title, design: .rounded))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.gray, .gray.opacity(0.2))
                })
            }
            
            Text("Why it is disabled?")
                .foregroundStyle(Color.white)
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("You shoud give permissons for Notifications in your app Settings")
                .foregroundStyle(Color.gray)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Button {
                Task {
                    if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                        await UIApplication.shared.open(url)
                    }
                }
            } label: {
                Text("Settings")
                    .font(.system(.title3, design: .rounded).bold())
                    .tint(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("primary_elements"), in: RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))

            }
        }
        .padding(16)
        .background(Color("primary_cell"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .frame(maxWidth: 500)
        .padding(.horizontal, 8)
    }
}

struct ThanksView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView {}
    }
}
