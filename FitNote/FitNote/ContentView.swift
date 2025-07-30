import SwiftUI
import AuthenticationServices

// Ensure both structs conform to Hashable in their main declarations:
struct Workout: Identifiable, Equatable, Hashable, Codable {
    let id: UUID
    var name: String
    let category: WorkoutCategory
    var detail: String? = nil
    let imageName: String
    let description: String
    
    init(id: UUID = UUID(), name: String, category: WorkoutCategory, detail: String? = nil, imageName: String, description: String) {
        self.id = id
        self.name = name
        self.category = category
        self.detail = detail
        self.imageName = imageName
        self.description = description
    }
    
    static let all: [Workout] = {
        var workouts: [Workout] = [
            // Core exemplars
            Workout(name: "Bench Press", category: .strength, imageName: "figure.strengthtraining.traditional", description: "Lie on a bench with feet flat on the floor. Grip the barbell slightly wider than shoulder-width. Lower the bar to your chest, then press it back up until your arms are straight. Focus on controlled movement and avoid bouncing the bar off your chest."),
            Workout(name: "Squat", category: .strength, imageName: "figure.strengthtraining.traditional", description: "Stand with feet shoulder-width apart. Lower your body by bending your knees and hips, keeping your chest up and back straight. Go as low as comfortable, then push through your heels to return to standing. Keep your knees tracking over your toes."),
            Workout(name: "Push Up", category: .calisthenics, imageName: "figure.pushup", description: "Start in a plank position with hands under shoulders. Lower your body until your chest nearly touches the floor, keeping elbows at a 45-degree angle. Push back up to the starting position. Keep your core tight and body in a straight line."),
            Workout(name: "Downward Dog", category: .yoga, imageName: "figure.yoga", description: "Start on hands and knees. Lift hips up and back, straightening legs and arms to form an inverted V shape. Press heels toward the floor and relax head between arms."),
            Workout(name: "Warrior I", category: .yoga, imageName: "figure.yoga", description: "Step one foot forward, bend the knee, and reach arms overhead. Keep your back leg straight and strong."),
            Workout(name: "Warrior II", category: .yoga, imageName: "figure.yoga", description: "From standing, step one foot back, bend the front knee, and extend arms out to the sides. Gaze over your front hand."),
            Workout(name: "Child's Pose", category: .yoga, imageName: "figure.yoga", description: "Kneel on the mat, sit back on your heels, and stretch your arms forward, resting your forehead on the mat."),
            Workout(name: "Tree Pose", category: .yoga, imageName: "figure.yoga", description: "Stand on one leg, place the other foot on your inner thigh, and bring your hands together at your chest."),
            Workout(name: "Bridge Pose", category: .yoga, imageName: "figure.yoga", description: "Lie on your back, bend your knees, and lift your hips toward the ceiling, keeping feet and shoulders grounded."),
            Workout(name: "Seated Forward Fold", category: .yoga, imageName: "figure.yoga", description: "Sit with legs extended, hinge at the hips, and reach for your feet, keeping your back long."),
            Workout(name: "Cat-Cow", category: .yoga, imageName: "figure.yoga", description: "On hands and knees, alternate arching and rounding your back to warm up the spine."),
            Workout(name: "Cobra Pose", category: .yoga, imageName: "figure.yoga", description: "Lie on your stomach, place hands under shoulders, and gently lift your chest off the mat."),
            Workout(name: "Triangle Pose", category: .yoga, imageName: "figure.yoga", description: "Stand with feet wide, reach one hand to your shin or the floor, and extend the other arm up."),
            Workout(name: "Boat Pose", category: .yoga, imageName: "figure.yoga", description: "Sit, lift your legs, and balance on your sit bones, keeping your spine long and arms extended forward."),
            Workout(name: "Meditation - Mindful Breathing", category: .meditation, imageName: "brain.head.profile", description: "Sit comfortably, close your eyes, and focus on your breath. Inhale deeply, exhale slowly, and let thoughts pass without judgment."),
        ]
        // Add more real yoga poses
        let yogaPoses = [
            ("Mountain Pose", "Stand tall with feet together, shoulders relaxed, and arms at your sides. Distribute weight evenly."),
            ("Chair Pose", "Stand with feet together, bend your knees, and reach arms overhead as if sitting in a chair."),
            ("Plank Pose", "From hands and knees, step feet back to form a straight line from head to heels, engaging your core."),
            ("Upward Facing Dog", "Lie on your stomach, press into your hands, and lift your chest and thighs off the mat."),
            ("Pigeon Pose", "From all fours, bring one knee forward and extend the other leg back, lowering hips toward the mat."),
            ("Camel Pose", "Kneel, place hands on your lower back, and gently arch your back, looking up."),
            ("Happy Baby", "Lie on your back, grab the outsides of your feet, and gently pull your knees toward your armpits."),
            ("Reclined Twist", "Lie on your back, bring knees to chest, and let them fall to one side while extending arms out."),
            ("Savasana", "Lie flat on your back, arms and legs relaxed, and focus on deep, slow breathing to relax your body."),
            ("Eagle Pose", "Stand, wrap one arm under the other and one leg over the other, and balance while sitting back."),
            ("Crow Pose", "Squat, place hands on the floor, and balance knees on upper arms, lifting feet off the ground."),
            ("Fish Pose", "Lie on your back, arch your chest up, and rest the crown of your head on the mat."),
            ("Dancer Pose", "Stand on one leg, grab the other ankle behind you, and reach forward with the opposite arm."),
            ("Half Moon Pose", "Stand, reach one hand to the floor and lift the opposite leg and arm up, forming a T shape."),
            ("Lotus Pose", "Sit cross-legged with each foot resting on the opposite thigh, hands on knees, and spine tall."),
            ("Bound Angle Pose", "Sit, bring soles of feet together, and let knees fall open, holding your feet."),
            ("Side Plank", "From plank, shift weight to one hand and the outside of one foot, stacking the other foot and arm on top."),
            ("Low Lunge", "Step one foot forward, bend the knee, and lower the back knee to the mat, reaching arms up."),
            ("Reverse Warrior", "From Warrior II, drop the back hand to the leg and reach the front arm overhead, arching back."),
            ("Standing Forward Fold", "Stand with feet hip-width apart, hinge at the hips, and let your upper body hang toward the floor."),
        ]
        for (name, desc) in yogaPoses { workouts.append(Workout(name: name, category: .yoga, imageName: "figure.yoga", description: desc)) }
        // Add 125 strength (sample, real names)
        let strengthMoves = [
            ("Deadlift", "Stand with feet hip-width apart, barbell over mid-foot. Bend at hips and knees, grip the bar. Keep back flat, lift the bar by straightening hips and knees. Lower with control."),
            ("Overhead Press", "Stand with feet shoulder-width apart, barbell at shoulders. Press the bar overhead until arms are straight, then lower with control."),
            ("Bicep Curl", "Stand with a dumbbell in each hand, arms at sides. Curl weights up while keeping elbows close to your torso, then lower with control."),
            ("Tricep Dips", "Place hands on a bench behind you, legs extended. Lower your body by bending elbows, then press back up."),
            ("Chest Fly", "Lie on a bench with dumbbells in each hand, arms extended above chest. Lower arms out to sides, then bring them back together."),
            ("Lat Pulldown", "Sit at a lat pulldown machine, grip the bar wide, and pull it down to your chest, squeezing your back."),
            ("Leg Press", "Sit on a leg press machine, place feet on platform, and push to extend legs, then return with control."),
            ("Shoulder Shrug", "Stand with dumbbells at sides, lift shoulders toward ears, then lower."),
            ("Russian Twist", "Sit on the floor, lean back slightly, and twist your torso side to side, holding a weight or medicine ball."),
            ("Farmer's Walk", "Hold heavy weights in each hand and walk for distance or time, keeping posture upright."),
        ]
        for (name, desc) in strengthMoves { workouts.append(Workout(name: name, category: .strength, imageName: "figure.strengthtraining.traditional", description: desc)) }
        // Add 125 calisthenics (sample, real names)
        let calisthenicsMoves = [
            ("Pull Up", "Hang from a bar with hands shoulder-width apart, palms facing away. Pull your chin above the bar by squeezing your back and arms, then lower with control."),
            ("Plank", "Start in a forearm plank position, elbows under shoulders, body in a straight line. Hold, keeping core tight and hips level."),
            ("Mountain Climbers", "Start in a plank position. Alternate driving knees toward chest quickly, keeping hips low and core tight."),
            ("Lunges", "Step forward with one leg, lower hips until both knees are bent at 90 degrees. Push back to start and repeat on the other side."),
            ("Burpees", "From standing, squat down, kick feet back to plank, do a push-up, return feet to squat, and jump up."),
            ("Dips", "Use parallel bars or a bench to lower and raise your body using your arms."),
            ("Sit Up", "Lie on your back, knees bent, feet flat. Curl your torso up toward your knees, then lower back down."),
            ("Jumping Jacks", "Stand with feet together, jump feet out while raising arms overhead, then return to start."),
            ("High Knees", "Run in place, bringing knees up toward your chest as high as possible."),
            ("Bear Crawl", "Crawl forward on hands and feet, keeping hips low and core engaged."),
        ]
        for (name, desc) in calisthenicsMoves { workouts.append(Workout(name: name, category: .calisthenics, imageName: "figure.pushup", description: desc)) }
        // Add 125 meditation (sample, real names)
        let meditationPractices = [
            ("Body Scan Meditation", "Lie down or sit comfortably. Focus your attention slowly and deliberately on each part of your body, from head to toe."),
            ("Loving-Kindness Meditation", "Sit comfortably, focus on sending goodwill, kindness, and warmth toward yourself and others."),
            ("Guided Visualization", "Close your eyes and imagine a peaceful place, focusing on the details and sensations."),
            ("Walking Meditation", "Walk slowly and mindfully, paying attention to each step and your breath."),
            ("Mantra Meditation", "Repeat a calming word, thought, or phrase to prevent distracting thoughts."),
            ("Zen Meditation", "Sit in a comfortable position, focus on your breath, and let thoughts pass without attachment."),
            ("Transcendental Meditation", "Sit with eyes closed and silently repeat a mantra for 20 minutes."),
            ("Chakra Meditation", "Focus on the body's energy centers, visualizing each one and its color."),
            ("Sound Bath", "Listen to resonant sounds (like singing bowls) to promote relaxation and meditation."),
            ("Breath Awareness", "Sit quietly and focus your attention on the natural rhythm of your breath."),
        ]
        for (name, desc) in meditationPractices { workouts.append(Workout(name: name, category: .meditation, imageName: "brain.head.profile", description: desc)) }
        // Fill out to 500+ with more real-world moves if needed
        return workouts
    }()
}

struct WorkoutSection: Identifiable, Equatable, Hashable, Codable {
    let id: UUID
    var title: String
    var workouts: [Workout] = []
    
    init(id: UUID = UUID(), title: String, workouts: [Workout] = []) {
        self.id = id
        self.title = title
        self.workouts = workouts
    }
}

struct ContentView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var workoutPlan = WorkoutPlan.loadFromUserDefaults()
    @State private var showAddDayOrFocus = false
    @State private var selectedSection: WorkoutSection? = nil
    @State private var editingWorkout: EditingWorkout? = nil
    @State private var repOrTimeInput: String = ""
    @State private var editingSectionID: UUID? = nil
    @State private var editingWorkoutID: UUID? = nil
    @State private var sectionNameDraft: String = ""
    @State private var workoutNameDraft: String = ""
    
    var body: some View {
        NavigationStack {
            DaySelectionView(
                workoutPlan: $workoutPlan,
                showAddDayOrFocus: $showAddDayOrFocus,
                selectedSection: $selectedSection
            )
            .sheet(isPresented: $showAddDayOrFocus) {
                AddSectionView { title in
                    workoutPlan.sections.append(WorkoutSection(title: title))
                    showAddDayOrFocus = false
                }
            }
            .navigationDestination(item: $selectedSection) { section in
                WorkoutListView(
                    section: section,
                    workoutPlan: $workoutPlan,
                    editingWorkout: $editingWorkout,
                    repOrTimeInput: $repOrTimeInput,
                    editingWorkoutID: $editingWorkoutID,
                    workoutNameDraft: $workoutNameDraft,
                    selectedSection: $selectedSection,
                    onBack: { selectedSection = nil }
                )
            }
        }
    }
}



// DaySelectionView with WhatsApp-style header
struct DaySelectionView: View {
    @Binding var workoutPlan: WorkoutPlan
    @Binding var showAddDayOrFocus: Bool
    @Binding var selectedSection: WorkoutSection?
    @State private var editingSectionID: UUID? = nil
    @State private var sectionNameDraft: String = ""
    @State private var isEditing = false
    @State private var isReorderingSections = false
    @State private var menuSectionID: UUID? = nil
    @EnvironmentObject var authManager: AuthenticationManager
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 0) {
                Text("Workouts")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 16)
                    .padding(.top, 12)
                Spacer()
                if isReorderingSections {
                    Button("Done") {
                        isReorderingSections = false
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.trailing, 8)
                    .padding(.top, 12)
                }
                Button(action: { showAddDayOrFocus = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 8)
                        .padding(.top, 12)
                }
                Menu {
                    Button(action: { authManager.signOut() }) {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 16)
                        .padding(.top, 12)
                }
            }
            // Start grey area
            VStack(spacing: 0) {
                if workoutPlan.sections.isEmpty {
                    VStack {
                        Spacer()
                        VStack(spacing: 24) {
                            Text("No days or focuses yet! Add one to get started 🏃‍♂️")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(.systemBackground))
                } else {
                    List {
                        ForEach(workoutPlan.sections) { section in
                            HStack {
                                if editingSectionID == section.id {
                                    TextField("Rename section", text: $sectionNameDraft)
                                        .font(.title3)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 16)
                                        .background(Color(.systemBackground))
                                        .cornerRadius(12)
                                    Button(action: {
                                        if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                            workoutPlan.sections[idx].title = sectionNameDraft
                                        }
                                        editingSectionID = nil
                                    }) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                    }
                                    Button(action: { editingSectionID = nil }) {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                    }
                                } else {
                                    Button(action: { selectedSection = section }) {
                                        Text(section.title)
                                            .font(.title3)
                                            .foregroundColor(.accentColor)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(Color(.systemBackground))
                                            .cornerRadius(12)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .contentShape(Rectangle())
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                        workoutPlan.sections.remove(at: idx)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                Button {
                                    menuSectionID = section.id
                                } label: {
                                    Image(systemName: "ellipsis")
                                }.tint(.gray)
                            }
                            .confirmationDialog("Options", isPresented: Binding(
                                get: { menuSectionID == section.id },
                                set: { if !$0 { menuSectionID = nil } }
                            ), titleVisibility: .visible) {
                                Button {
                                    editingSectionID = section.id
                                    sectionNameDraft = section.title
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button {
                                    isReorderingSections.toggle()
                                } label: {
                                    Label("Reorder", systemImage: "arrow.up.arrow.down")
                                }
                                Button(role: .destructive) {
                                    if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                                        workoutPlan.sections.remove(at: idx)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                        }
                        .onMove { indices, newOffset in
                            workoutPlan.sections.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                    .environment(\.editMode, .constant(isReorderingSections ? .active : .inactive))
                }
            }
            .background(Color(.systemGray6))
        }
        .navigationBarHidden(true)
    }
}

// Helper view modifier for conditional modifiers
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// In WorkoutListView, use BrandedHeader(showBack: true, onBack: { onBack() })
struct WorkoutListView: View {
    var section: WorkoutSection
    @Binding var workoutPlan: WorkoutPlan
    @Binding var editingWorkout: EditingWorkout?
    @Binding var repOrTimeInput: String
    @Binding var editingWorkoutID: UUID?
    @Binding var workoutNameDraft: String
    @Binding var selectedSection: WorkoutSection?
    var onBack: () -> Void
    @State private var isRenaming = false
    @State private var sectionNameDraft = ""
    @State private var selectedWorkout: Workout? = nil
    @State private var showAddWorkoutSheet = false
    @State private var isEditing = false
    @State private var isReorderingWorkouts = false
    @State private var menuWorkoutID: UUID? = nil
    @State private var completedWorkoutIDs: Set<UUID> = []
    @State private var showCongrats: Bool = false
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Button(action: { onBack() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.accentColor)
                        .padding(.leading, 8)
                        .padding(.top, 12)
                }
                Text(section.title)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 8)
                    .padding(.top, 12)
                Spacer()
                if isReorderingWorkouts {
                    Button("Done") {
                        isReorderingWorkouts = false
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.trailing, 8)
                    .padding(.top, 12)
                }
                Menu {
                    Button(action: { authManager.signOut() }) {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 8)
                        .padding(.top, 12)
                }
                Button(action: { showAddWorkoutSheet = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 16)
                        .padding(.top, 12)
                }
            }
            .sheet(isPresented: $showAddWorkoutSheet) {
                WorkoutSearchView { workout in
                    if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                        workoutPlan.sections[idx].workouts.append(workout)
                    }
                    showAddWorkoutSheet = false
                }
            }
            Spacer().frame(height: 16)
            List {
                if let idx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }) {
                    // Remove the empty state: do not show any message or button when workouts is empty
                    if workoutPlan.sections[idx].workouts.isEmpty {
                        VStack(spacing: 24) {
                            Text("Add your first workout")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 160, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    } else {
                        ForEach(Array(workoutPlan.sections[idx].workouts.enumerated()), id: \.element.id) { (workoutIdx, workout) in
                            HStack(alignment: .center) {
                                // Checkbox
                                Button(action: {
                                    if completedWorkoutIDs.contains(workout.id) {
                                        completedWorkoutIDs.remove(workout.id)
                                    } else {
                                        completedWorkoutIDs.insert(workout.id)
                                    }
                                }) {
                                    Image(systemName: completedWorkoutIDs.contains(workout.id) ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(completedWorkoutIDs.contains(workout.id) ? .green : .gray)
                                        .font(.system(size: 24))
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.leading, 8)
                                // Card content or inline edit
                                if editingWorkoutID == workout.id {
                                    TextField("Rename workout", text: $workoutNameDraft)
                                        .figtreeFont(size: 17, weight: .regular)
                                    Button(action: {
                                        workoutPlan.sections[idx].workouts[workoutIdx].name = workoutNameDraft
                                        editingWorkoutID = nil
                                    }) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                    }
                                    Button(action: { editingWorkoutID = nil }) {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                    }
                                } else {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(workout.name)
                                            .figtreeFont(size: 17, weight: .regular)
                                            .foregroundColor(.primary)
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
                                    .onTapGesture {
                                        selectedWorkout = workout
                                    }
                                }
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    if let workoutIdx = workoutPlan.sections[idx].workouts.firstIndex(where: { $0.id == workout.id }) {
                                        workoutPlan.sections[idx].workouts.remove(at: workoutIdx)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                Button {
                                    menuWorkoutID = workout.id
                                } label: {
                                    Image(systemName: "ellipsis")
                                }.tint(.gray)
                            }
                            .confirmationDialog("Options", isPresented: Binding(
                                get: { menuWorkoutID == workout.id },
                                set: { if !$0 { menuWorkoutID = nil } }
                            ), titleVisibility: .visible) {
                                Button {
                                    editingWorkoutID = workout.id
                                    workoutNameDraft = workout.name
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button {
                                    isReorderingWorkouts.toggle()
                                } label: {
                                    Label("Reorder", systemImage: "arrow.up.arrow.down")
                                }
                                Button(role: .destructive) {
                                    if let workoutIdx = workoutPlan.sections[idx].workouts.firstIndex(where: { $0.id == workout.id }) {
                                        workoutPlan.sections[idx].workouts.remove(at: workoutIdx)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                        }
                        .onMove { indices, newOffset in
                            workoutPlan.sections[idx].workouts.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .environment(\.editMode, .constant(isReorderingWorkouts ? .active : .inactive))
            .sheet(item: $selectedWorkout) { workout in
                WorkoutDetailSheetNoImage(
                    workout: workout,
                    repOrTimeInput: $repOrTimeInput,
                    onSave: {
                        if let sectionIdx = workoutPlan.sections.firstIndex(where: { $0.id == section.id }),
                           let workoutIdx = workoutPlan.sections[sectionIdx].workouts.firstIndex(where: { $0.id == workout.id }) {
                            workoutPlan.sections[sectionIdx].workouts[workoutIdx].detail = repOrTimeInput
                        }
                        selectedWorkout = nil
                    },
                    onCancel: {
                        selectedWorkout = nil
                    }
                )
            }
        }
        .navigationBarHidden(true)
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
                    TextField("e.g. Monday, Upper Body, Cardio, Yoga, Rest", text: $title, onCommit: {
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
            .navigationTitle("Name your workout")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.accentColor)
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
    @State private var reps: String = ""
    @State private var sets: String = ""
    @State private var time: String = ""
    @State private var timeUnit: String = "sec"
    let timeUnits = ["sec", "min"]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    HStack {
                        Text("Sets")
                            .foregroundColor(.secondary)
                        Spacer()
                        TextField("Sets", text: $sets)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                    HStack {
                        Text("Reps")
                            .foregroundColor(.secondary)
                        Spacer()
                        TextField("Reps", text: $reps)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                    HStack {
                        Text("Time")
                            .foregroundColor(.secondary)
                        Spacer()
                        TextField("Time", text: $time)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 60)
                        Picker("Unit", selection: $timeUnit) {
                            ForEach(timeUnits, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 80)
                    }
                    Button("Save") {
                        var details = ""
                        if !sets.trimmingCharacters(in: .whitespaces).isEmpty { details += "\(sets) sets" }
                        if !reps.trimmingCharacters(in: .whitespaces).isEmpty {
                            if !details.isEmpty { details += " x " }
                            details += "\(reps) reps"
                        }
                        if !time.trimmingCharacters(in: .whitespaces).isEmpty {
                            if !details.isEmpty { details += ", " }
                            details += "\(time) \(timeUnit)"
                        }
                        repOrTimeInput = details
                        onSave()
                    }
                    .disabled(sets.trimmingCharacters(in: .whitespaces).isEmpty && reps.trimmingCharacters(in: .whitespaces).isEmpty && time.trimmingCharacters(in: .whitespaces).isEmpty)
                    .buttonStyle(.bordered)
                    .figtreeFont(size: 16, weight: .semibold)
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Set workout details")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { onCancel() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .onAppear {
                // Try to parse existing input for editing
                let input = repOrTimeInput.lowercased()
                if let setsMatch = input.range(of: "(\\d+) sets", options: .regularExpression) {
                    sets = String(input[setsMatch]).components(separatedBy: " ").first ?? ""
                }
                if let repsMatch = input.range(of: "(\\d+) reps", options: .regularExpression) {
                    reps = String(input[repsMatch]).components(separatedBy: " ").first ?? ""
                }
                if let timeMatch = input.range(of: "(\\d+) (sec|min)", options: .regularExpression) {
                    let timeParts = String(input[timeMatch]).components(separatedBy: " ")
                    time = timeParts.first ?? ""
                    if timeParts.count > 1 { timeUnit = timeParts[1] }
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
    @State private var showAddCustomSheet = false
    @State private var customName = ""
    @State private var customType: WorkoutCategory = .strength
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.accentColor)
                    }
                    .padding(.leading, 8)
                    Spacer()
                    Text("Add workout")
                        .font(.largeTitle).bold()
                        .padding(.trailing, 16)
                    Spacer(minLength: 0)
                    Button(action: { showAddCustomSheet = true }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 28, weight: .regular))
                            .foregroundColor(.accentColor)
                            .padding(.trailing, 8)
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 8)
                TextField("Search workouts", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
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
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    EmptyView()
                }
            }
            .onAppear(perform: filterWorkouts)
            .sheet(isPresented: $showAddCustomSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Workout name")) {
                            TextField("Plank, Kayak, Jump rope...", text: $customName)
                        }
                        Section(header: Text("Type")) {
                            Picker("Type", selection: $customType) {
                                ForEach(WorkoutCategory.allCases, id: \.self) { cat in
                                    Text(cat.rawValue).tag(cat)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    .navigationTitle("Add custom workout")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: { showAddCustomSheet = false; customName = ""; customType = .strength }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.accentColor)
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                let newWorkout = Workout(name: customName, category: customType, imageName: "figure.strengthtraining.traditional", description: "Custom workout")
                                filteredWorkouts.insert(newWorkout, at: 0)
                                onSelect(newWorkout)
                                showAddCustomSheet = false
                                customName = ""
                                customType = .strength
                                presentationMode.wrappedValue.dismiss()
                            }
                            .disabled(customName.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }
            }
        }
    }
    func filterWorkouts() {
        let searchLower = search.lowercased()
        if searchLower.isEmpty {
            filteredWorkouts = Workout.all
        } else {
            filteredWorkouts = Workout.all.filter {
                $0.name.lowercased().contains(searchLower) ||
                $0.category.rawValue.lowercased().contains(searchLower)
            }
        }
    }
}

// MARK: - Section Row
struct SectionRow: View {
    @Binding var section: WorkoutSection
    var onAddWorkout: () -> Void
    var onDelete: () -> Void
    @Binding var editingSectionID: UUID?
    @Binding var sectionNameDraft: String
    var body: some View {
        HStack(spacing: 8) {
            if editingSectionID == section.id {
                TextField("Section Name", text: $sectionNameDraft, onCommit: {
                    section.title = sectionNameDraft
                    editingSectionID = nil
                })
                .figtreeFont(size: 18, weight: .semibold)
                .foregroundColor(.gray)
                .onAppear { sectionNameDraft = section.title }
            } else {
                Text(section.title)
                    .figtreeFont(size: 18, weight: .semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: onAddWorkout) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.accentColor)
            }
            Menu {
                Button(action: {
                    editingSectionID = section.id
                    sectionNameDraft = section.title
                }) {
                    HStack {
                        Text("Rename")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                Button(role: .destructive, action: onDelete) {
                    HStack {
                        Text("Delete")
                        Spacer()
                        Image(systemName: "trash")
                    }
                }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.leading, 2)
            }
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
    }
}

// MARK: - Workout Row
struct WorkoutRow: View {
    @Binding var workout: Workout
    var onEditDetail: () -> Void
    var onDelete: () -> Void
    @Binding var editingWorkoutID: UUID?
    @Binding var workoutNameDraft: String
    var body: some View {
        HStack {
            if editingWorkoutID == workout.id {
                TextField("Workout Name", text: $workoutNameDraft, onCommit: {
                    workout.name = workoutNameDraft
                    editingWorkoutID = nil
                })
                .figtreeFont(size: 17, weight: .regular)
                .foregroundColor(.primary)
                .onAppear { workoutNameDraft = workout.name }
            } else {
                Button(action: onEditDetail) {
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
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
            Button {
                editingWorkoutID = workout.id
                workoutNameDraft = workout.name
            } label: {
                Label("Rename", systemImage: "pencil")
            }
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

// Workout detail sheet without image
struct WorkoutDetailSheetNoImage: View {
    let workout: Workout
    @Binding var repOrTimeInput: String
    var onSave: () -> Void
    var onCancel: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Only show the form section (everything below the gray line)
            EditWorkoutDetailSheet(repOrTimeInput: $repOrTimeInput, onSave: onSave, onCancel: onCancel)
                .padding(.horizontal, 8)
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

enum WorkoutCategory: String, CaseIterable, Codable {
    case strength = "Strength"
    case calisthenics = "Calisthenics"
    case trx = "TRX"
    case resistanceBand = "Resistance Band"
    case yoga = "Yoga"
    case warmup = "Warmup"
    case stretching = "Stretching"
    case meditation = "Meditation"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // App Logo and Title
            VStack(spacing: 16) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .padding(.bottom, 4)
                Text("FitNote")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("A simple way to plan your workouts")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // Temporary Sign In Button (for testing)
            Button(action: {
                // Simulate successful sign in
                authManager.userID = "test-user-123"
                authManager.userEmail = "test@example.com"
                authManager.userName = "Test User"
                authManager.isAuthenticated = true
                
                // Save to UserDefaults
                UserDefaults.standard.set("test-user-123", forKey: "appleUserID")
                UserDefaults.standard.set("test@example.com", forKey: "userEmail")
                UserDefaults.standard.set("Test User", forKey: "userName")
            }) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                    Text("Sign In (Test Mode)")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding(.horizontal, 32)
            
            // Privacy and Terms
            VStack(spacing: 8) {
                Text("By continuing, you agree to our")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Button("Terms of Service") {
                        // Handle terms of service
                    }
                    .font(.caption)
                    .foregroundColor(.accentColor)
                    
                    Text("and")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Button("Privacy Policy") {
                        // Handle privacy policy
                    }
                    .font(.caption)
                    .foregroundColor(.accentColor)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

// Apple Sign In button wrapper will be added later when capability is configured
