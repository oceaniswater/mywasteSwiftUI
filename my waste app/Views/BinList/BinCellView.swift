//
//  BinCellView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct BinCellView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var vm: BinsListViewModel
    var bin: Bin
    
    @State var viewOffset: CGFloat = 2
    @State var showRemove = false
    @State var removeRow = false
    
    let baseOffset: CGFloat = -2
    let deleteOffset: CGFloat = -40
    let animationDuration: TimeInterval = 0.3
    
    let dragLimit: CGFloat = 30
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        viewOffset = deleteOffset
                        showRemove = true
                    }
                } else if value.translation.width > 0 {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        viewOffset = baseOffset
                        showRemove = false
                    }
                    
                }
            }
    }
    
    var body: some View {
        ZStack(alignment: .leading){
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
                    bin.notifyMe ? nil :
                    Image(systemName: "bell.slash")
                        .foregroundStyle(.red)
                }
                .padding(.all, 10)
                .background(Color("primary_cell"))
                .cornerRadius(10.00)
                .frame(maxHeight: 100.00)
            }
            .offset(x: viewOffset)
            
            HStack {
                Spacer()
                Button {
                    deleteRow()
                } label: {
                    Image(systemName:"multiply")
                        .font(.system(size: 25, weight:
                                .semibold))
                        .foregroundColor(Color("primary_elements"))
                    
                    
                }
                .buttonStyle(.plain)
                .opacity(showRemove ? 1 : 0)
                .opacity(removeRow ? 0 : 1)
                .offset(x: 0)
                .frame (width: 32, height: 32)
                
            }
            .zIndex(4)
            
            EmitterView()
                .opacity(removeRow ? 1 : 0)
        }
        .onAppear {
            self.viewOffset = 2
        }
        .gesture(dragGesture)
    }
    
    func deleteRow() {
        withAnimation(.default) {
            removeRow = true
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(.easeInOut(duration: animationDuration)) {
                viewOffset = -UIScreen.main.bounds.width
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 2.5, repeats: false) { _ in
            delete()
        }
    }
    
    func delete() {
        Task {
            await vm.deleteNotifications(for: bin.id.uuidString)
            modelContext.delete(bin)
        }
    }
}

struct BinCellView_Previews: PreviewProvider {
    static var previews: some View {
        BinCellView(bin: Bin(date: .now, type: .cardboard, color: .yellow, selectDays: [.Fri]))
            .environmentObject(BinsListViewModel())
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
    }
}
