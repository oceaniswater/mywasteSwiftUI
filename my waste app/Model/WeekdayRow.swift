//
//  WeekdayRow.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI

struct WeekdayRow: View {
    var day: Day
    @Binding var selectedItems: Set<Day>
    
    var isSelected: Bool {
        selectedItems.contains(day)
    }
    
    var body: some View {
        HStack {
            Text(day.dayString)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .frame(height: 20)
        .onTapGesture {
            if isSelected {
                self.selectedItems.remove(day)
            } else {
                self.selectedItems.insert(day)
            }
        }
    }
}

struct WeekdayRow_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayRow(day: .Fri, selectedItems: .constant([.Fri, .Mon]))
    }
}
