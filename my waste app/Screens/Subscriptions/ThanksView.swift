//
//  ThanksView.swift
//  my waste app
//
//  Created by Mark Golubev on 21/08/2023.
//

import SwiftUI

struct ThanksView: View {
    
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text("Thank You 💕")
                .foregroundStyle(Color.white)
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("Now you have ability to use all power of this app. In the future we gonna add more fetures into it. And you will use it for free too.")
                .foregroundStyle(Color.gray)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Button(action: didTapClose) {
                Text("Close")
                    .font(.system(.title3, design: .rounded).bold())
                    .tint(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))
            }
        }
        .padding(16)
        .background(Color("primary_cell"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 8)
    }
}

struct ThanksView_Previews: PreviewProvider {
    static var previews: some View {
        ThanksView {}
    }
}
