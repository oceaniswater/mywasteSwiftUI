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
            VStack(spacing:10) {
                Text("When app should notify you?")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Color.black)
                HStack(spacing: 30) {
                    VStack(spacing:10) {
                        Text("At the collection day")
                            .multilineTextAlignment(.leading)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color.black)
                            .frame(height: 35.0)
                        Image(systemName: atTheSameDay ? "circle.fill" : "circle")
                            .onTapGesture {
                                withAnimation {
                                    atTheSameDay.toggle()
                                    atTheDayBefore.toggle()
                                    
                                }
                            }
//                        Button(action: {
//                            withAnimation {
//                                atTheSameDay.toggle()
//                                atTheDayBefore.toggle()
//                            }
//                        }, label: {
//                            Image(systemName: atTheSameDay ? "circle.fill" : "circle")
//                        })
                        
                    }
                    VStack(spacing:10) {
                        Text("At the day before")
                            .multilineTextAlignment(.leading)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundStyle(Color.black)
                            .frame(height: 35.0)
                        Image(systemName: atTheDayBefore ? "circle.fill" : "circle")
                            .onTapGesture {
                                withAnimation {
                                    atTheSameDay.toggle()
                                    atTheDayBefore.toggle()
                                    
                                }
                            }
//                        Button(action: {
//                            withAnimation {
//                                atTheSameDay.toggle()
//                                atTheDayBefore.toggle()
//                            }
//                        }, label: {
//                            Image(systemName: atTheDayBefore ? "circle.fill" : "circle")
//                        })
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
