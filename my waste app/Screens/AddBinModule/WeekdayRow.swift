//
//  WeekdayRow.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI

struct WeekdayRow: View {
    var weekday: WeekDay
    @Binding var selectedItems: Set<String>
    
    var isSelected: Bool {
        selectedItems.contains(weekday.id)
    }
    
    var body: some View {
        HStack {
            Text(weekday.name)
            Spacer()
            if isSelected {
                Image(systemName: "trash.fill")
            }
        }

        .padding(.horizontal)
        .contentShape(Rectangle())
        .frame(height: 55)
        .onTapGesture {
            if isSelected {
                self.selectedItems.remove(weekday.id)
            } else {
                self.selectedItems.insert(weekday.id)
            }
        }
        
    }
}

struct WeekdayRow_Previews: PreviewProvider {
    static var previews: some View {
        let id = "2"
        WeekdayRow(weekday: WeekDay(id: "2", name: "Monday"), selectedItems: .constant([id]))
    }
}
