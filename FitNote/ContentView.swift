//
//  ContentView.swift
//  FitNote
//
//  Created by Daniela Hirsch on 23/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var workoutPlan = WorkoutPlan.loadFromUserDefaults()
    @State private var showAddDayOrFocus = false
    @State private var selectedSection: WorkoutSection? = nil
    @State private var editingWorkout: EditingWorkout? = nil
    @State private var repOrTimeInput: String = ""
    @State private var editingSection: WorkoutSection? = nil
    @State private var editingSectionTitle: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    // Top-left logo for main app
                    HStack(spacing: 8) {
                        Image(systemName: "figure.strengthtraining.traditional")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.accentColor)
                        Text("FitNote")
                            .font(.custom("PlayfairDisplay", size: 28))
                    }
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    if workoutPlan.sections.isEmpty {
                        VStack(spacing: 24) {
                            Spacer()
                            Text("Welcome to FitNote 🎉")
                                .font(.custom("PlayfairDisplay", size: 32))
                                .multilineTextAlignment(.center)
                            Text("Let's set up your workout plan.")
                                .figtreeFont(size: 20, weight: .medium)
                                .multilineTextAlignment(.center)
                            Button("Add day or focus") {
                                showAddDayOrFocus = true
                            }
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ScrollView {
                            VStack(spacing: 24) {
                                ForEach(Array(workoutPlan.sections.enumerated()), id: \.element.id) { sectionIndex, section in
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack {
                                            Text(section.title)
                                                .figtreeFont(size: 18, weight: .semibold)
                                                .foregroundColor(.gray)
                                                .onTapGesture {
                                                    editingSection = section
                                                    editingSectionTitle = section.title
                                                }
                                            Spacer()
                                            Button(action: {
                                                selectedSection = section
                                            }) {
                                                Image(systemName: "plus.circle")
                                            }
                                            Menu {
                                                Button("Rename") {
                                                    editingSection = section
                                                    editingSectionTitle = section.title
                                                }
                                                Button(role: .destructive) {
                                                    if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                                        workoutPlan.sections.remove(at: idx)
                                                    }
                                                } label: {
                                                    Text("Delete")
                                                }
                                            } label: {
                                                Image(systemName: "ellipsis")
                                                    .rotationEffect(.degrees(90))
                                                    .padding(.leading, 8)
                                            }
                                        }
                                        .padding(.bottom, 16)
                                        .padding(.horizontal, 16)
                                        VStack(spacing: 0) {
                                            ForEach(Array(section.workouts.enumerated()), id: \.element.id) { workoutIndex, workout in
                                                HStack {
                                                    Button(action: {
                                                        editingWorkout = EditingWorkout(sectionID: section.id, workoutID: workout.id)
                                                        repOrTimeInput = workout.detail ?? ""
                                                    }) {
                                                        HStack {
                                                            Text(workout.name)
                                                                .figtreeFont(size: 17, weight: .regular)
                                                                .foregroundColor(.primary)
                                                            Spacer()
                                                            if let detail = workout.detail, !detail.isEmpty {
                                                                Text(detail)
                                                                    .figtreeFont(size: 14, weight: .regular)
                                                                    .foregroundColor(.blue)
                                                            }
                                                            Text(workout.category.rawValue)
                                                                .figtreeFont(size: 14, weight: .regular)
                                                                .foregroundColor(.gray)
                                                        }
                                                        .padding(.vertical, 12)
                                                        .padding(.horizontal, 16)
                                                    }
                                                    .background(Color.clear)
                                                    Menu {
                                                        Button("Edit details") {
                                                            editingWorkout = EditingWorkout(sectionID: section.id, workoutID: workout.id)
                                                            repOrTimeInput = workout.detail ?? ""
                                                        }
                                                        Button(role: .destructive) {
                                                            if let sectionIdx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                                                workoutPlan.sections[sectionIdx].workouts.removeAll { $0.id == workout.id }
                                                            }
                                                        } label: {
                                                            Text("Delete")
                                                        }
                                                    } label: {
                                                        Image(systemName: "ellipsis")
                                                            .rotationEffect(.degrees(90))
                                                            .padding(.leading, 8)
                                                    }
                                                }
                                                .background(Color.clear)
                                                if workout.id != section.workouts.last?.id {
                                                    Divider()
                                                        .padding(.leading, 16)
                                                }
                                            }
                                            .onDelete { indexSet in
                                                if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                                    workoutPlan.sections[idx].workouts.remove(atOffsets: indexSet)
                                                }
                                            }
                                        }
                                        .background(Color.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color(.black).opacity(0.04), radius: 4, x: 0, y: 2)
                                    }
                                }
                                .onDelete { indexSet in
                                    workoutPlan.sections.remove(atOffsets: indexSet)
                                }
                                Button("Add day or focus") {
                                    showAddDayOrFocus = true
                                }
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
            .onChange(of: workoutPlan) { _ in
                workoutPlan.saveToUserDefaults()
            }
            .sheet(isPresented: $showAddDayOrFocus) {
                AddSectionView { title in
                    workoutPlan.sections.append(WorkoutSection(title: title))
                    showAddDayOrFocus = false
                }
            }
            .sheet(item: $selectedSection) { section in
                WorkoutSearchView { workout in
                    if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                        workoutPlan.sections[idx].workouts.append(workout)
                    }
                    selectedSection = nil // Dismiss the sheet
                }
            }
            .sheet(item: $editingWorkout, onDismiss: { repOrTimeInput = "" }) { edit in
                EditWorkoutDetailSheet(
                    repOrTimeInput: $repOrTimeInput,
                    onSave: {
                        if let sectionIdx = workoutPlan.sections.firstIndex(where: { $0.id == edit.sectionID }),
                           let workoutIdx = workoutPlan.sections[sectionIdx].workouts.firstIndex(where: { $0.id == edit.workoutID }) {
                            workoutPlan.sections[sectionIdx].workouts[workoutIdx].detail = repOrTimeInput
                        }
                        editingWorkout = nil
                    },
                    onCancel: {
                        editingWorkout = nil
                    }
                )
            }
            .sheet(item: $editingSection) { section in
                NavigationView {
                    Form {
                        TextField("Section name", text: $editingSectionTitle)
                            .figtreeFont(size: 17)
                    }
                    .navigationTitle("Rename section")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                    workoutPlan.sections[idx].title = editingSectionTitle
                                }
                                editingSection = nil
                            }
                            .disabled(editingSectionTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                editingSection = nil
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Font Modifiers
struct FigtreeFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight = .regular
    func body(content: Content) -> some View {
        content.font(.custom("Figtree", size: size).weight(weight))
    }
}
extension View {
    func figtreeFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(FigtreeFontModifier(size: size, weight: weight))
    }
}

// MARK: - EditingWorkout for Sheet
struct EditingWorkout: Identifiable, Equatable {
    let sectionID: UUID
    let workoutID: UUID
    var id: String { "\(sectionID.uuidString)-\(workoutID.uuidString)" }
}

// MARK: - Add Section View
struct AddSectionView: View {
    var onAdd: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    var body: some View {
        NavigationView {
            Form {
                HStack(spacing: 8) {
                    TextField("E.g. Monday, leg day, push, full body...", text: $title, onCommit: {
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
                            onAdd(title)
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
                    .figtreeFont(size: 17)
                    Button("Add") {
                        onAdd(title)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                    .buttonStyle(.bordered)
                    .figtreeFont(size: 16, weight: .semibold)
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Name your day or focus")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Edit Workout Detail Sheet
struct EditWorkoutDetailSheet: View {
    @Binding var repOrTimeInput: String
    var onSave: () -> Void
    var onCancel: () -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reps or time")) {
                    HStack(spacing: 8) {
                        TextField("e.g. 12 reps or 60 sec", text: $repOrTimeInput, onCommit: {
                            if !repOrTimeInput.trimmingCharacters(in: .whitespaces).isEmpty {
                                onSave()
                            }
                        })
                        Button("Save") {
                            onSave()
                        }
                        .disabled(repOrTimeInput.trimmingCharacters(in: .whitespaces).isEmpty)
                        .buttonStyle(.bordered)
                        .figtreeFont(size: 16, weight: .semibold)
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Set workout details")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
            }
        }
    }
}

// MARK: - Workout Search View
struct WorkoutSearchView: View {
    var onSelect: (Workout) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var search = ""
    @State private var filteredWorkouts: [Workout] = Workout.all
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search workouts", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .figtreeFont(size: 17)
                    .onChange(of: search) { newValue in
                        filterWorkouts()
                    }
                List(filteredWorkouts) { workout in
                    Button(action: {
                        onSelect(workout)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(workout.name)
                            Spacer()
                            Text(workout.category.rawValue)
                                .figtreeFont(size: 14, weight: .regular)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Add workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear(perform: filterWorkouts)
        }
    }
    func filterWorkouts() {
        if search.isEmpty {
            filteredWorkouts = Workout.all
        } else {
            filteredWorkouts = Workout.all.filter { $0.name.localizedCaseInsensitiveContains(search) || $0.category.rawValue.localizedCaseInsensitiveContains(search) }
        }
    }
}

// MARK: - Models
struct WorkoutPlan: Codable, Equatable {
    var sections: [WorkoutSection] = []
    
    static let userDefaultsKey = "fitnote_workout_plan"
    
    static func loadFromUserDefaults() -> WorkoutPlan {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let plan = try? JSONDecoder().decode(WorkoutPlan.self, from: data) {
            return plan
        }
        return WorkoutPlan()
    }
    
    func saveToUserDefaults() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: WorkoutPlan.userDefaultsKey)
        }
    }
}

struct WorkoutSection: Identifiable, Equatable, Codable {
    let id: UUID
    var title: String
    var workouts: [Workout] = []
    
    init(id: UUID = UUID(), title: String, workouts: [Workout] = []) {
        self.id = id
        self.title = title
        self.workouts = workouts
    }
}

struct Workout: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let category: WorkoutCategory
    var detail: String? = nil
    
    init(id: UUID = UUID(), name: String, category: WorkoutCategory, detail: String? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.detail = detail
    }
    
    static let all: [Workout] = [
        // Strength Training
        Workout(name: "Bench Press", category: .strength),
        Workout(name: "Squat", category: .strength),
        Workout(name: "Deadlift", category: .strength),
        Workout(name: "Overhead Press", category: .strength),
        Workout(name: "Barbell Row", category: .strength),
        // Calisthenics
        Workout(name: "Push Up", category: .calisthenics),
        Workout(name: "Pull Up", category: .calisthenics),
        Workout(name: "Dips", category: .calisthenics),
        Workout(name: "Plank", category: .calisthenics),
        Workout(name: "Bodyweight Squat", category: .calisthenics),
        // TRX
        Workout(name: "TRX Row", category: .trx),
        Workout(name: "TRX Chest Press", category: .trx),
        Workout(name: "TRX Y Fly", category: .trx),
        // Resistance Band
        Workout(name: "Band Pull Apart", category: .resistanceBand),
        Workout(name: "Band Squat", category: .resistanceBand),
        Workout(name: "Band Bicep Curl", category: .resistanceBand),
        // More
        Workout(name: "Lunges", category: .strength),
        Workout(name: "Mountain Climbers", category: .calisthenics),
        Workout(name: "TRX Pike", category: .trx),
        Workout(name: "Band Tricep Extension", category: .resistanceBand),
        // Add more as needed
    ]
}

enum WorkoutCategory: String, CaseIterable, Codable {
    case strength = "Strength"
    case calisthenics = "Calisthenics"
    case trx = "TRX"
    case resistanceBand = "Resistance Band"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
