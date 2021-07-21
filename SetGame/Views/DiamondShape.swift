//
//  DiamondShape.swift
//  SetGame
//
//  Created by krkota on 14/07/21.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top = CGPoint(x: center.x, y: center.y - rect.height/2)
        let left = CGPoint(x: center.x - rect.width/2, y: center.y)
        let bottom = CGPoint(x: center.x, y: center.y + rect.height/2)
        let right = CGPoint(x: center.x + rect.width/2, y: center.y)
        
        var path = Path()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: bottom)
        path.addLine(to: right)
        path.addLine(to: top)
        return path
    }
}

struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        DiamondShape()
    }
}
