//
//  StarShape.swift
//  SetGame
//
//  Created by krkota on 14/07/21.
//

import SwiftUI

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top = CGPoint(x: center.x, y: center.y - rect.height * 0.6)
        let left1 = CGPoint(x: center.x - rect.width/6, y: center.y - rect.height/4)
        let left2 = CGPoint(x: center.x - rect.width/2, y: center.y - rect.height/6)
        let left3 = CGPoint(x: center.x - rect.width/4, y: center.y + rect.height/8)
        let left4 = CGPoint(x: center.x - rect.width * 0.35, y: center.y + rect.height * 0.55)
        let bottom = CGPoint(x: center.x, y: center.y + rect.height * 0.3)
        let right1 = CGPoint(x: center.x + rect.width/6, y: center.y - rect.height/4)
        let right2 = CGPoint(x: center.x + rect.width/2, y: center.y - rect.height/6)
        let right3 = CGPoint(x: center.x + rect.width/4, y: center.y + rect.height/8)
        let right4 = CGPoint(x: center.x + rect.width * 0.35, y: center.y + rect.height * 0.55)
        
        var path = Path()
        path.move(to: top)
        path.addLine(to: left1)
        path.addLine(to: left2)
        path.addLine(to: left3)
        path.addLine(to: left4)
        path.addLine(to: bottom)
        path.addLine(to: right4)
        path.addLine(to: right3)
        path.addLine(to: right2)
        path.addLine(to: right1)
        path.addLine(to: top)
        return path
    }
}

struct StarShape_Previews: PreviewProvider {
    static var previews: some View {
        StarShape()
    }
}
