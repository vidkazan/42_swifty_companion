//
//  StrokeView.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

class StrokeView : UIView {
	var points : [CGPoint] = []
	let strokeColor : UIColor
	let strokeWidth : CGFloat
	var height : CGFloat?
	var width : CGFloat?
	init(strokeColor : UIColor, strokeWidth: CGFloat) {
		self.strokeWidth = strokeWidth
		self.strokeColor = strokeColor
		super.init(frame: .zero)
	}
	
	func setFrameSize(w : CGFloat, h: CGFloat){
		self.width = w
		self.height = h
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		guard let context = UIGraphicsGetCurrentContext() else { return }
		context.setStrokeColor(strokeColor.cgColor)
		context.setLineWidth(strokeWidth)
		context.setLineCap(.round)
		
		for (index,point) in points.enumerated() {
			if index == 0 {
				context.move(to: point)
			} else {
				context.addLine(to: point)
			}
		}
		context.strokePath()
	}
	
	func setPoints(points : [CGPoint]) {
		self.points = points
		setNeedsDisplay()
	}
}

