//
//  AnimationsDemo.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 12/06/2026.
//

import SwiftUI

struct AnimationsDemo: View {
    @State var isCircleExpanded: Bool = false
    @State var isPink: Bool = true
    
    @State var degree: Double = .zero
    @State var isAirplaneVisible: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text("KATO")
                .rotationEffect(.degrees(30))
                .scaleEffect(4)
                .offset(x: 60)
            Circle()
                .foregroundStyle(isPink ? .pink: .blue)
                .frame(width: isCircleExpanded ? 200 : 100)
                .onTapGesture {
                    withAnimation(.spring(
                        duration: 5,
                        bounce: 0.7)
                    ) {
                        isCircleExpanded.toggle()
                        isPink.toggle()
                    }
                }
            Image(systemName: "arrow.triangle.2.circlepath.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(degree))
            bouncyCircles
            pulsingHeart
            if isAirplaneVisible {
                slidingAirplane
            }
        }.onAppear {
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                degree = 360
            }
            
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                isAirplaneVisible.toggle()
            }
        }
    }
    
    var slidingAirplane: some View {
        Image(systemName: "airplane")
            .resizable()
            .frame(width: 50, height: 50)
            .transition(.move(edge: .leading))
    }
    
    var pulsingHeart: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let scale = 1 + abs(sin(t * .pi))
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .scaleEffect(scale)
        }
    }
    
    var bouncyCircles: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            
            HStack {
                ForEach(1...8, id: \.self) { i in
                    let y = cos(t * 6 + Double(i) * .pi/4) * 20
                    
                    Circle()
                        .foregroundStyle(.pink)
                        .offset(y: y)
                }
            }
        }
        .padding(.horizontal, 30)
    }
}
#Preview {
    AnimationsDemo()
}
