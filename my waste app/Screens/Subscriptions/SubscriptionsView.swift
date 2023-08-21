//
//  SubscriptionsView.swift
//  my waste app
//
//  Created by Mark Golubev on 21/08/2023.
//

import SwiftUI
import StoreKit

struct SubscriptionsView: View {
    @EnvironmentObject var store: SubscriptionStore
    
    let title: String
    let description: String
    
    var didTapClose: () -> ()

    
    var body: some View {
                
            VStack(spacing: 8) {
                
                HStack {
                    Spacer()
                    Button(action: didTapClose, label: {
                        
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                            .font(.system(.largeTitle, design: .rounded).bold())
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.gray, .gray.opacity(0.2))
                    })
                }
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(.title2, design: .rounded).bold())
                    .multilineTextAlignment(.center)
                
                
                Text(description)
                    .foregroundStyle(.gray)
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                ForEach(store.items) { item in
                    configureProductVw(item)
                }
                
                Text(!store.purchasedNonConsumables.isEmpty ? "You already have subscription" : "")
                    .foregroundStyle(.gray)
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                Button("Restore purchase") {
                    Task {
                        try? await store.restore()
                    }
                }
                .foregroundStyle(Color("primary_elements").opacity(0.6))
                .padding(.bottom, 16)
                
            }
            .padding(16)
            .background(Color("primary_bg"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(8)
            .overlay(alignment: .top) {
                Image("logo")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 60, height: 60)
                    .offset(y: -25)
            }
        
    }
    
    func configureProductVw(_ item: Product) -> some View {
        
        HStack {
            
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundStyle(.white)
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button(item.displayPrice) {
                Task {
                    await store.purchase(item)
                }
            }
            .tint((Color("primary_elements")))
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color("primary_cell"),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
}

#Preview {
    SubscriptionsView(title: "Unlock all app functions!", description: "Unlock all app functions. All subscriptions goes with 1 week free trial. Try. Enjoy. Cancel any time in Apple Subscriptions.") {
        ///
    }
    .environmentObject(SubscriptionStore())
}
