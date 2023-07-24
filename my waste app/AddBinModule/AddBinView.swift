//
//  AddBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct AddBinView: View {
    
    @State var colorSelected: BinColor = .red
    @State var typeSelected: BinType = .glass
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $colorSelected)
                    ColorPicker(colorSelected: $colorSelected)
                    TypePicker(typeSelected: $typeSelected)
                    Spacer()
                }
            }
        }
    }
}

struct AddBinView_Previews: PreviewProvider {
    static var previews: some View {
        AddBinView()
    }
}

struct ImageBin: View {
    @Binding var colorSelected: BinColor
    var body: some View {
        Image(colorSelected.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 200)
            .padding()
    }
}

struct ColorPicker: View {
    @Binding var colorSelected: BinColor
    var body: some View {
        List {
            Picker("Color", selection: $colorSelected) {
                ForEach(BinColor.allCases) { bin in
                    Text(bin.rawValue)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .pickerStyle(.wheel)
    }
}

struct TypePicker: View {
    @Binding var typeSelected: BinType
    var body: some View {
        List {
            Picker("Type", selection: $typeSelected) {
                ForEach(BinType.allCases) { bin in
                    Text(bin.rawValue)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .clipped()
        .pickerStyle(.automatic)
    }
}
