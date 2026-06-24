//
//  Models.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import Foundation
import SwiftData

@Model
final class Student {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var gpa: Double
    var enrolled: Date
    
    var faculty: Faculty
    @Relationship(deleteRule: .cascade, inverse: \CourseGrade.student)
    var courseGrades: [CourseGrade]
    
    init(name: String, gpa: Double, enrolled: Date, faculty: Faculty, courseGrades: [CourseGrade]) {
        self.name = name
        self.gpa = gpa
        self.enrolled = enrolled
        self.faculty = faculty
        self.courseGrades = courseGrades
    }
}

@Model
final class Faculty {
    var id: UUID = UUID()
    var facultyType: FacultyType
    
    enum `FacultyType`: CaseIterable, Equatable, Codable, Hashable {
        case macs(MacsSchool)
        case esm
        case vasds(VaadsSchool)
        case martva
        case law
        case aziaAfrika
        case physics
        
        static var allCases: [FacultyType] {
            MacsSchool.allCases.map { .macs($0) }
            + [.esm]
            + VaadsSchool.allCases.map { .vasds($0) }
            + [.martva, .law, .aziaAfrika, .physics]
        }
        
        enum MacsSchool: CaseIterable, Codable {
            case sauketeso
            case enginner
            case gaji
        }
        
        enum VaadsSchool: CaseIterable, Codable {
            case architecture
            case design
            case visualArt
        }
    }
    
    @Relationship(deleteRule: .cascade, inverse: \Student.faculty)
    var students: [Student]
    
    init(facultyType: FacultyType, students: [Student]) {
        self.facultyType = facultyType
        self.students = students
    }
}

@Model
final class Course {
    var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \CourseGrade.course)
    var courseGrades: [CourseGrade]
    
    init(name: String, courseGrades: [CourseGrade]) {
        self.name = name
        self.courseGrades = courseGrades
    }
}

@Model
final class CourseGrade {
    var student: Student
    var course: Course
    var grade: Double
    
    init(student: Student, course: Course, grade: Double) {
        self.student = student
        self.course = course
        self.grade = grade
    }
}
