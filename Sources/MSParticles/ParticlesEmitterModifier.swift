//
//  ParticlesEmitterModifier.swift
//
//
//  Created by Moritz Scholz on 11.02.22.
//

import SwiftUI

/// Call `.toggle()` on this to start the animation.
public typealias MSAnimationToggle = Bool

public extension View {
    /// Attaches a particle emitter to this view.
    ///
    /// Call `animate.toggle()` to start the animation.
    ///
    /// - Note: If a new animation is started while a previous animation is still running, the animation is
    ///     reset and begins from the start again.
    ///
    /// - Example:
    ///     ```
    ///     @State private var fireworksAnimation: MSAnimationToggle = false
    ///     // ...
    ///     Button("Fireworks!") {
    ///         fireworksAnimation.toggle()
    ///     }
    ///     .particlesEmitter(animate: $fireworksAnimation) {
    ///         Image(systemName: "star.fill")
    ///             .foregroundColor(.yellow)
    ///     }
    ///     ```
    ///
    func particlesEmitter<Particle>(
        animate: Binding<Bool>,
        animation: Animation = .spring(dampingFraction: 1.2),
        numberOfParticles: Int = 30,
        spread: MSParticlesSpread = .random(10...100),
        directions: MSParticlesDirection = .random(Angle.zero...Angle.radians(2*Double.pi)),
        colorful: Bool = false,
        particle: @escaping () -> Particle) -> some View where Particle: View {
            modifier(ParticlesEmitterModifier(
                animate: animate,
                animation: animation,
                numberOfParticles: numberOfParticles,
                spread: spread,
                directions: directions,
                colorful: colorful,
                particle: particle))
        }
}

private struct ParticlesEmitterModifier<Particle>: ViewModifier where Particle: View {
    /// Toggle this to start the animation.
    @Binding var animate: MSAnimationToggle

    /// Settings for the particles emitter.
    var animation: Animation
    var numberOfParticles: Int
    var spread: MSParticlesSpread
    var directions: MSParticlesDirection
    var colorful: Bool
    var particle: () -> Particle

    /// Animation percentage of the particles emitter.
    @State private var percentage: Double = 0.0
    /// We are using this to reset the view-ID thus making the emitter a new view and by that reset the
    /// animation each time it is triggered. Not resetting the view-ID leads to the animation being played
    /// backwards when it is triggered again while still animating.
    @State private var viewID: UUID = .init()

    func body(content: Content) -> some View {
        /// Workaround: There seems to be a bug making the animation only play twice sometimes. This
        /// is resolved by wrapping the view into an HStack.
        HStack(spacing: 0) {
            content
                .background(
                    MSParticlesEmitter(percentage: $percentage,
                                       numberOfParticles: numberOfParticles,
                                       spread: spread,
                                       directions: directions,
                                       colorful: colorful,
                                       particle: particle)
                        .id(viewID)
                )
                .onChange(of: animate) { _ in
                    // Reset animation state
                    viewID = .init()
                    percentage = 0.0

                    // Start new animation
                    withAnimation(animation) {
                        percentage = 1.0
                    }
                }
        }
    }
}
