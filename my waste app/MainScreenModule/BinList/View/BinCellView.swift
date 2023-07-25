//
//  BinCellView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct BinCellView: View {
    @Binding var bin: Bin
    
    var body: some View {
        ZStack {
            Color(.clear)
            HStack(alignment: .top) {
                Image(bin.color.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, alignment: .center)
                VStack(alignment: .leading) {
                    Text("\(bin.type.rawValue) bin")
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        HStack {
                            Text("days:")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(bin.days.map({$0.name}).joined(separator: ", "))
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
                Button {
                    //
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                }

            }
            .padding(.all, 10)
            .background(Color("primary_cell"))
            .cornerRadius(10.00)
        .frame(maxHeight: 100.00)
        }
    }
}

struct BinCellView_Previews: PreviewProvider {
    static var previews: some View {
        BinCellView(bin: .constant(Bin(color: .blue, type: .glass, days: [WeekDay(name: "Monday")])))
    }
}
