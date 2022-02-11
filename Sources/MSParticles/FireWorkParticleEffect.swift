//
//  FireWorkParticleEffect.swift
//
//
//  Created by Moritz Scholz on 29.01.22.
//

import SwiftUI

/// An effect that, when applied to several particles, creates something looking like fireworks.
/// The particle modified by this effect will move in the given direction (angle in radians) up to the given
/// distance as `t` increases.
///
struct FireWorkParticleEffect: GeometryEffect {
    // swiftlint:disable:next identifier_name
    var t: Double
    var direction: Double
    var distance: Double

    var animatableData: Double {
        get { t }
        set { t = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translationX = t * distance * cos(direction)
        let translationY = t * distance * sin(direction)
        let affineTranslation = CGAffineTransform(translationX: translationX,
                                                  y: translationY)
        return ProjectionTransform(affineTranslation)
    }
}
