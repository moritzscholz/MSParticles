//
//  Previews.swift
//
//
//  Created by Moritz Scholz on 29.01.22.
//

import SwiftUI

#if DEBUG
struct ParticleEmitterPreview: View {
    @State private var animation1: MSAnimationToggle = false
    @State private var animation2: MSAnimationToggle = false
    @State private var animation3: MSAnimationToggle = false
    @State private var animation4: MSAnimationToggle = false
    @State private var animation5: MSAnimationToggle = false
    @State private var animation6: MSAnimationToggle = false

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                Button("Yay!") {
                    animation1.toggle()
                }
                .particlesEmitter(animate: $animation1) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                Spacer()

                Button("Yay!") {
                    animation2.toggle()
                }.particlesEmitter(
                    animate: $animation2,
                    colorful: true) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                Spacer()

                Button("Yay!") {
                    animation3.toggle()
                }.particlesEmitter(
                    animate: $animation3,
                    animation: .spring(dampingFraction: 3.0),
                    directions: .random(Angle.degrees(200)...Angle.degrees(340))) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                Spacer()
            }
            Spacer()

            HStack {
                Spacer()

                Button("Yay!") {
                    animation4.toggle()
                }.particlesEmitter(
                    animate: $animation4,
                    animation: .spring(dampingFraction: 5.0)) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                Spacer()

                Button("Yay!") {
                    animation5.toggle()
                }.particlesEmitter(
                    animate: $animation5,
                    animation: .spring(dampingFraction: 5.0),
                    numberOfParticles: 50,
                    spread: .fixed(100),
                    directions: .uniform(Angle.zero...Angle.radians(2*Double.pi)),
                    colorful: true) {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.red)
                    }
                Spacer()

                Button("Yay!") {
                    animation6.toggle()
                }.particlesEmitter(
                    animate: $animation6,
                    animation: .spring(dampingFraction: 1.5),
                    numberOfParticles: 20,
                    spread: .random(30...90)) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.purple)
                    }
                Spacer()
            }
            Spacer()
        }
    }
}

struct MSParticleEmitter_Previews: PreviewProvider {
    static var previews: some View {
        ParticleEmitterPreview()
    }
}
#endif
