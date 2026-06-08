//
//  ContentView.swift
//  SwiftUIBasics
//
//  Created by Tamar Gelashvili on 08/06/2026.
//

import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    @Published var name: String = "Tamar"
    @Published var count: Int = .zero
}

struct ContentView: View {
    @State private var buttonTitle: String = "Tap"
    @State private var exampleBool: Bool = false
    
    @State private var textFieldVals: TextfieldValues = .init()
    @State private var picked: Int = .zero
    @State private var date: Date = Date()

    @StateObject private var vm: ViewModel = .init()
    
    struct TextfieldValues {
        var emailText: String = ""
        var passwordText: String = ""
    }

    enum Focus {
        case email
        case password
    }
    
    @FocusState var focus: Focus?
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            mainView
        }
        .onAppear() {
            print("ON APPEAR")
        }
        .onDisappear {
            print("DISAPPEAR")
        }
        .task {
            await asyncFunc()
        }
    }
    
    func asyncFunc() async {
        try? await Task.sleep(nanoseconds: 100_000_000)
        print("ASYNC")
    }
    
    @ViewBuilder
    var mainView: some View {
        ScrollView {
            VStack {
                Picker("PICKER TITLE", selection: $picked) {
                    Text("Kato").tag(0)
                    Text("Lela").tag(1)
                    Text("Ani").tag(2)
                }
                
                DatePicker("DATE", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                
                
                Stepper("Stepper", value: $vm.count, step: 2)
                    .padding(20)
                Text("VALUE: \(vm.count)")
                
                Text("Kato")
                    .font(.largeTitle)
                //.foregroundStyle(.red)
                    .lineLimit(3)
                    .bold()
                    .italic()
                    .tracking(5)
                    .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                
//                    .background(.purple, in: RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 200)
                
                Text(attributedExample)
                Button(buttonTitle) {
                    buttonTitle = "Tapped"
                }
                
                
                Rectangle()
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.orange)
                    .overlay(alignment: .leading) {
                        Circle()
                        Text("Lela")
                            .foregroundStyle(.black)
                    }
                
                //.foregroundStyle(.blue)
                    .buttonStyle(.glass)
                
                
                GeometryReader { proxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: proxy.size.width * 0.75)
                            Rectangle()
                                .foregroundStyle(.green)
                                .frame(width: proxy.size.width * 0.25)
                        }
                    }
                }.frame(height: 100)
                
                Image(systemName: "person.badge.clock.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .symbolEffect(.breathe, options: .repeat(.periodic(5)))
                    .foregroundStyle(.red, .blue)
                
                
                Group {
                    TextField("Email", text: $textFieldVals.emailText)
                        .onSubmit {
                            focus = .password
                        }
                        .focused($focus, equals: .email)
                    PasswordTextField(
                        passwordText: $textFieldVals.passwordText,
                        vm: vm
                    )
                        .focused($focus, equals: .password)
                }
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
                .padding(.horizontal, 50)
            }
        }
        .foregroundStyle(.white)
    }
    
    var attributedExample: AttributedString {
        var string: AttributedString = "This is Attributed string"
        let range = string.range(of: "Attributed")!
        string[range].foregroundColor = .purple
        return string
    }
}

struct PasswordTextField: View {
    @Binding var passwordText: String
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        Button(vm.name) {
            vm.name += "1"
        }
        Text("Enter your password")
        SecureField("Password", text: $passwordText)
    }
}

#Preview {
    ContentView()
}
