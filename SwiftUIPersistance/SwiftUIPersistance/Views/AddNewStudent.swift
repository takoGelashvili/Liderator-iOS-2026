//
//  AddNewStudent.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import SwiftUI
import SwiftData

struct AddNewStudent: View {
    @Query private var faculties: [Faculty]
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    struct GPA {
        var whole: Int
        var decimal: Int
    }
    
    @State private var name: String = ""
    @State private var gpa: GPA = .init(whole: 4, decimal: 0)
    @State private var date: Date = .now
    @State private var faculty: Faculty.FacultyType = .aziaAfrika
    
    var body: some View {
        VStack(spacing: 60) {
            TextField("Student name", text: $name)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 4)
                        .foregroundStyle(.gray.opacity(0.6))
                }
            
            VStack {
                Text("Enter GPA")
                    .font(.title3)
                HStack {
                    GPAPicker(max: 4, gpaNum: $gpa.whole)
                    GPAPicker(max: 99, gpaNum: $gpa.decimal)
                }.pickerStyle(.wheel)
            }
            
            DatePicker("Pick Enrollment Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.compact)
            
            Picker("Pick faculty", selection: $faculty) {
                ForEach(Faculty.FacultyType.allCases, id: \.self) { faculty in
                    Text(faculty.rawValue)
                        .foregroundStyle(faculty.color)
                        .tag(faculty.rawValue)
                }
            }
            
            Button("Add user") {
                context.insert(
                    Student(
                        name: name,
                        gpa: Double(gpa.whole) + Double(gpa.decimal)/100,
                        enrolled: date,
                        faculty: faculties.first(where: { $0.facultyType == faculty })!,
                        courseGrades: []
                    )
                )
                try? context.save()
                dismiss()
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    struct GPAPicker: View {
        let max: Int
        @Binding var gpaNum: Int
        
        var body: some View {
            Picker("", selection: $gpaNum) {
                ForEach(0...max, id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
}

#Preview {
    AddNewStudent()
}
