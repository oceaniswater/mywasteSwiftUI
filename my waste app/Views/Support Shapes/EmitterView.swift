//
//  EmitterView.swift
//  my waste app
//
//  Created by Mark Golubev on 17/11/2023.
//

import SwiftUI

struct EmitterView: UIViewRepresentable {
    // MARK: - Variables
    let emitterConfigurations: [EmitterConfiguration] = [
        EmitterConfiguration(birthRate: 300, lifeTame: 300, velocity: 100.0, velocityRange: 100, xAcceleration: 4, yAcceleration: 1, emissionRange: 180 * .pi, spin: 90 * .pi, spinRange: 100 * (.pi / 180), scale: 0.04, scaleRange: 0.25),
        
        EmitterConfiguration(birthRate: 150, lifeTame: 30, velocity: 20, velocityRange: 100, xAcceleration: 4, yAcceleration: 0, emissionRange: 10.0 * .pi, spin: 90 * .pi, spinRange: 100 * (.pi / 180), scale: 0.05, scaleRange: 0.24)
    ]
    

    // MARK: - Functions
    func makeUIView(context: Context) -> some UIView {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 44)
        let containerView = UIView(frame: CGRect(origin: .zero, size: size))
        
        var emitterCells: [CAEmitterCell] = []
        
        let particleLayer = CAEmitterLayer()
        particleLayer.frame = containerView.frame
        
        containerView.layer.addSublayer(particleLayer)
        containerView.layer.masksToBounds = true
        
        particleLayer.emitterShape = .circle
        particleLayer.emitterPosition = CGPoint(x: 600, y: 0)
        particleLayer.emitterSize = CGSize(width: 1648.0, height: 48)
        particleLayer.emitterMode = .volume
        particleLayer.renderMode = .unordered
        
        for configuration in emitterConfigurations {
            let emitterCell = CAEmitterCell()
            
            emitterCell.contents = configuration.content
            emitterCell.birthRate = configuration.birthRate
            emitterCell.lifetime = configuration.lifeTame
            
            emitterCell.velocity = configuration.velocity
            emitterCell.velocityRange = configuration.velocityRange
            
            emitterCell.xAcceleration = configuration.xAcceleration
            emitterCell.yAcceleration = configuration.yAcceleration
            emitterCell.emissionRange = configuration.emissionRange
            
            emitterCell.spinRange = configuration.spinRange
            emitterCell.spin = configuration.spin
            emitterCell.scale = configuration.scale
            emitterCell.scaleRange = configuration.scaleRange
            
            emitterCells.append(emitterCell)
            
        }
        particleLayer.emitterCells = emitterCells
        return containerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

#Preview {
    EmitterView()
}
