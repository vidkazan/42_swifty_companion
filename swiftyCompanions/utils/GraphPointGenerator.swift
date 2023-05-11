//
//  GraphPointGenerator.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import Foundation
import UIKit

class GraphPointGenerator {
	private let height : Int
	private let width : Int
	private let insets : Int
	
	private let xMax : Int
	private let xMin : Int
	private let yMax : Int
	private let yMin : Int
	
	init(height: Int, width: Int, insets: Int) {
		self.width = width
		self.height = height
		self.insets = insets
		
		self.xMin = self.insets
		self.xMax = self.width - self.insets
		self.yMin = self.height - self.insets
		self.yMax = self.insets
	}
	
	func generatePoints(with points : [(Int,Int)]) -> [CGPoint] {
		var res : [CGPoint] = []
		var tmp : [(Int,Int)] = []
		var maxValue : Int = 0
		var maxKey : Int = 0
		
		for point in points {
			maxValue = point.1 + maxValue
			tmp.append((point.0,maxValue))
		}
		maxKey = tmp.last?.0 ?? 0
		maxValue = tmp.last?.1 ?? 0
		
		res.append(CGPoint(x: xMin, y: yMin))
		for point in tmp {
			if maxKey != 0, maxValue != 0 {
				res.append(
					CGPoint(
						x: xMin + ( (xMax - xMin) * point.0 / maxKey ),
						y: yMin + ( (yMax - yMin) * point.1 / maxValue))
				)
			}
		}
		
		if res.count < 2 {
			res.append(CGPoint(x: xMax, y: yMin + ( (yMax - yMin) * maxValue)))
		}
		return res
	}
	
	func getDifLabelValue(valueDiff : Int) -> String {
		if valueDiff  > 0 {
			return "▲" + String(abs(valueDiff))
		} else if valueDiff == 0 {
			return String(abs(valueDiff))
		} else {
			return "▼" + String(abs(valueDiff))
		}
	}
	
	func getDifLabelColor(valueDiff : Int) -> UIColor {
		if valueDiff  > 0 {
			return UIColor.CompanionColors.textGreen
		} else if valueDiff == 0 {
			return UIColor.CompanionColors.textHide
		} else {
			return UIColor.CompanionColors.textRed
		}
	}
}
