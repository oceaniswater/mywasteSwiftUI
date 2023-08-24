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
            Color.white
            VStack(spacing:5) {
                Text("When app should notify you?")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Color.black)
                HStack(spacing: 30) {
                    VStack(spacing:5) {
                        Text("At the collection day")
                            .multilineTextAlignment(.leading)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color.black)
                            .frame(height: 35.0)
                        Image(systemName: atTheSameDay ? "bell.badge.fill" : "bell.badge")
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                withAnimation {
                                    atTheSameDay.toggle()
                                    atTheDayBefore.toggle()
                                    
                                }
                            }
                    }
                    VStack(spacing:5) {
                        Text("At the day before")
                            .multilineTextAlignment(.leading)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color.black)
                            .frame(height: 35.0)
                        Image(systemName: atTheDayBefore ? "bell.badge.fill" : "bell.badge")
                            .foregroundStyle(.blue)
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
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .padding( 20.0)
    }
}

#Preview {
    NotifyDayToggleView(atTheSameDay: .constant(false), atTheDayBefore: .constant(true))
}
