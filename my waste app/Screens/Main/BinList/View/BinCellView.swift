//
//  BinCellView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct BinCellView: View {
    var bin: Bin
 
    var body: some View {
        ZStack {
            Color(.clear)
            HStack(alignment: .top) {
                ZStack {
                    Image(bin.color.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, alignment: .center)
                    Image(bin.type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 25)
                }
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("\(bin.type.rawValue.capitalized(with: .current)) waste")
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(Color.white)
                    Text(bin.noteLabel)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .font(.system(.footnote, design: .rounded))
                        .foregroundStyle(Color.gray)
                        .frame(height: 35.0)
                }
                .padding()
                Spacer()
                Image(systemName: !bin.notifyMe ? "bell.slash" : "")
                    .foregroundStyle(.red)
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
        BinCellView(bin: Bin(date: .now, type: .cardboard, color: .yellow, selectDays: [.Fri]))
    }
}
