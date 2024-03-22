//
//  AddHabit.swift
//  HabitTracking
//
//  Created by Leah Somerville on 3/21/24.
//

import SwiftUI

struct AddHabit: View {
    @State private var name = "Habit"
    @State private var frequency = 0
    
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Title", text: $name)

            }
            .navigationTitle("Add a New Habit")
            .toolbar {
                Button("Save") {
                    let item = HabitItem(name: name, frequency: frequency)
                    habits.habitList.append(item)
                    dismiss()
                }
            }
        }
        
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits:  Habits())
    }
}

