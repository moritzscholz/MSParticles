//
//  MSParticlesEmitter.swift
//
//
//  Created by Moritz Scholz on 29.01.22.
//

import SwiftUI

/// A particle emitter that can be animated to create and spread particles. The particle can be any `View`.
///
public struct MSParticlesEmitter<Particle>: View
where Particle: View {
    @Binding var animationPercentage: Double

    private let numberOfParticles: Int
    private let particleSpread: ClosedRange<Double>
    private let particleDirections: MSParticlesDirection
    private let colorful: Bool
    private let particle: () -> Particle

    public init(percentage: Binding<Double>,
                numberOfParticles: Int = 30,
                spread: MSParticlesSpread = .random(10...100),
                directions: MSParticlesDirection = .random(Angle.zero...Angle.radians(2*Double.pi)),
                colorful: Bool = false,
                particle: @escaping () -> Particle) {
        self._animationPercentage = percentage
        self.numberOfParticles = numberOfParticles
        self.particleSpread = spread.range
        self.particleDirections = directions
        self.colorful = colorful
        self.particle = particle
    }

    public var body: some View {
        ZStack {
            ForEach(0...numberOfParticles, id: \.self) { index in
                particle()
                    .hueRotation(colorful ? hueRotationAngle(forParticleAt: index)
                                 : .zero)
                    .scaleEffect(animationPercentage)
                    .modifier(FireWorkParticleEffect(
                        t: animationPercentage,
                        direction: particleDirections.direction(forParticleAt: index,
                                                                of: numberOfParticles),
                        distance: .random(in: particleSpread)))
                    .opacity(1 - animationPercentage)

            }
        }
    }

    private func hueRotationAngle(forParticleAt index: Int) -> Angle {
        .radians(2*Double.pi
                 // Change color throughout the animation
                 * animationPercentage
                 // Different color change for each particle
                 * Double(index) / Double(numberOfParticles))
    }
}

/// Indicates how far the particles should spread.
/// `fixed` has all particles spread to the same given distance uniformly.
/// `random` has particles spread to a random distance within the given range.
///
public enum MSParticlesSpread {
    case fixed(Double)
    case random(ClosedRange<Double>)

    var range: ClosedRange<Double> {
        switch self {
        case .fixed(let fixedValue):
            return fixedValue...fixedValue
        case .random(let range):
            return range
        }
    }
}

/// Direction the particle spread into.
/// `random` means that each particle moves along a randomly chosen angle within the given range.
/// `uniform` means that each particle's direction angle is chosen uniformly within the given range.
///
public enum MSParticlesDirection {
    case random(ClosedRange<Angle>)
    case uniform(ClosedRange<Angle>)

    func direction(forParticleAt index: Int, of numberOfParticles: Int) -> Double {
        switch self {
        case .random:
            return .random(in: radRange)
        case .uniform:
            guard numberOfParticles > 0 else { return radRange.lowerBound }

            return radRange.lowerBound
            + (radRange.upperBound - radRange.lowerBound) * Double(index) / Double(numberOfParticles)
        }
    }

    /// Closed range of directions in radians.
    private var radRange: ClosedRange<Double> {
        let range: ClosedRange<Angle>
        switch self {
        case .random(let value):
            range = value
        case .uniform(let value):
            range = value
        }

        return range.lowerBound.radians...range.upperBound.radians
    }
}
