//
//  ContentView.swift
//  Habit
//
//  Created by Michael Wolf on 1/23/22.
//

import SwiftUI

struct AddHabitSheet: View {
    @State private var text = ""
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Enter Habit") {
                TextField("New Habit", text: $text)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.orange, lineWidth: 2))
            }
            Section("Action") {
                HStack {
                    Spacer()
                    Button("Save") {
                        if (text != "") {
                            habits.habits.append(Habit(name: text))
                        }
                        dismiss()
                    }.padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.orange, lineWidth: 2))
                    Spacer()
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }.padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.orange, lineWidth: 2))
                    Spacer()
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabitSheet = false
    
    func removeRows(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                List {
                    ForEach(habits.habits) { habit in
                        HStack {
                            Text("\(habit.name)")
                            Spacer()
                            Text("\(habit.streakLength)")
                            Button("Increment") {habits.increment(id: habit.id)}
                                .padding(2)
                                .overlay(RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.orange, lineWidth: 1))
                        }
                    }.onDelete(perform: removeRows)
                }
                
                Spacer()
                
                Button("Add Habit") {
                    showingAddHabitSheet.toggle()
                }.sheet(isPresented: $showingAddHabitSheet) {
                    AddHabitSheet(habits: habits)
                }.padding()
                 .overlay(RoundedRectangle(cornerRadius: 8)
                 .stroke(Color.orange, lineWidth: 2))
                
                Spacer()
            }.navigationTitle("HABITS:")
             .toolbar{EditButton()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
