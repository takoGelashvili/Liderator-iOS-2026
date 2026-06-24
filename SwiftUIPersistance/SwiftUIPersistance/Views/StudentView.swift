//
//  StudentView.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import SwiftUI

struct StudentView: View {
    let student: Student

    var body: some View {
        VStack {
            Text(student.name)
                .font(.largeTitle)
            Text(student.gpa.formatted())
                .font(.title)
                .foregroundStyle(student.gpaColor)
            
            HStack {
                Text("\(student.enrolled)")
                Text(student.faculty.facultyType.rawValue)
                    .font(.headline)
            }
        }
        .padding(30)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(student.faculty.facultyType.color.opacity(0.5))
        }
    }
}
