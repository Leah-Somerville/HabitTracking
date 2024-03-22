//
//  ContentView.swift
//  HabitTracking
//
//  Created by Leah Somerville on 3/21/24.
//

import SwiftUI

struct HabitItem: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var frequency: Int
}

class Habits: ObservableObject{
    @Published var habitList: [HabitItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habitList) {
                UserDefaults.standard.set(encoded, forKey: "HabitList")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "HabitList") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                habitList = decodedItems
                return
            }
        }
        habitList = []
    }
}


struct ContentView: View {
    @StateObject var habits = Habits()
    
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List{
                Section{
                    ForEach(habits.habitList, id: \.self) { habit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                            }
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("Habit Tracking")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabit(habits: Habits())
        }
    }
    func removeItems(at offsets: IndexSet) {
        habits.habitList.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
