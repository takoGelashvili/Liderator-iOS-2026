//
//  ContentView.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(
        filter: #Predicate<Student> { $0.gpa > 2.3 },
        sort: \Student.gpa,
        order: .reverse
    ) var students: [Student]
    @Query var faculties: [Faculty]
    @Environment(\.modelContext) var context
    
    @State var addNewStudentPresented: Bool = false
    
    var body: some View {
        Image(systemName: "person.fill.badge.plus")
            .resizable()
            .frame(width: 100, height: 100)
            .onTapGesture {
                addNewStudentPresented = true
            }
        List {
            Section {
                ForEach(students) { student in
                    StudentView(student: student)
                }
                .onDelete { indexSet in
                    let toDelete = students[indexSet.first!]
                    context.delete(toDelete)
                    try? context.save()
                }
            }
        }
        .listStyle(.insetGrouped)
        .sheet(isPresented: $addNewStudentPresented, content: {
            AddNewStudent()
        })
//        .onAppear {
//            setUpDefaults()
//        }
    }
        
    func setUpDefaults() {
        Faculty.FacultyType.allCases.forEach { type in
            context.insert(Faculty(facultyType: type, students: []))
        }
        
        context.insert(Student(
            name: "Gaso",
            gpa: 3.93,
            enrolled: .now,
            faculty: faculties.first(where: { $0.facultyType == .macs(.sauketeso) })!,
            courseGrades: []
        ))
        
        context.insert(Student(
            name: "Lela",
            gpa: 5.00,
            enrolled: .now,
            faculty: faculties.first(where: { $0.facultyType == .aziaAfrika })!,
            courseGrades: []
        ))
        
        context.insert(Student(
            name: "Mate",
            gpa: 3.99,
            enrolled: .now,
            faculty: faculties.first(where: { $0.facultyType == .macs(.enginner) })!,
            courseGrades: []
        ))
        
        context.insert(Student(
            name: "Kato",
            gpa: 27,
            enrolled: .now,
            faculty: faculties.first(where: { $0.facultyType == .vasds(.architecture) })!,
            courseGrades: []
        ))
        
        try? context.save()
    }
}

#Preview {
    ContentView()
}
