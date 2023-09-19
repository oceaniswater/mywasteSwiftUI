//
//  NotifyDayToggleView.swift
//  my waste app
//
//  Created by Mark Golubev on 27/08/2023.
//

import SwiftUI

struct NotifyDayToggleView: View {
    @Binding var atTheSameDay: Bool
    @Binding var atTheDayBefore: Bool
    
    var body: some View {
        ZStack {
            Color(.backgroundOne)
            VStack(spacing:5) {
                Text("When do you want to receive notifications?")
                    .multilineTextAlignment(.center)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Color(.textOne))
                HStack(spacing: 30) {
                    VStack(spacing:5) {
                        Text("On the collection day")
                            .multilineTextAlignment(.center)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color(.textOne))
                            .frame(height: 35.0)
                        Image(systemName: atTheSameDay ? "bell.badge.fill" : "bell.badge")
                            .foregroundStyle(Color("primary_elements"))
                            .onTapGesture {
                                withAnimation {
                                    atTheSameDay.toggle()
                                    atTheDayBefore.toggle()
                                    
                                }
                            }
                    }
                    VStack(spacing:5) {
                        Text("The day before")
                            .multilineTextAlignment(.center)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color(.textOne))
                            .frame(height: 35.0)
                        Image(systemName: atTheDayBefore ? "bell.badge.fill" : "bell.badge")
                            .foregroundStyle(Color("primary_elements"))
                            .onTapGesture {
                                withAnimation {
                                    atTheSameDay.toggle()
                                    atTheDayBefore.toggle()
                                    
                                }
                            }
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .padding( 20.0)
    }
}

#Preview {
    NotifyDayToggleView(atTheSameDay: .constant(false), atTheDayBefore: .constant(true))
}
