//
//  Particle.swift
//  my waste app
//
//  Created by Mark Golubev on 17/11/2023.
//

import UIKit.UIImage

struct EmitterConfiguration {
    let birthRate: Float
    let lifeTame: Float
    let velocity: CGFloat
    
    let velocityRange: CGFloat
    let xAcceleration: CGFloat
    let yAcceleration: CGFloat
    let emissionRange: CGFloat
    
    let spin: CGFloat
    let spinRange: CGFloat
    let scale: CGFloat
    let scaleRange: CGFloat
    
    let content: CGImage? = UIImage(named: FillRandomiser.getRandomFill().rawValue)?.cgImage
}
