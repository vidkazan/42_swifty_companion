//
//  CustomViews.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation
import UIKit

class GraphView : UIView {
	init(){
		super.init(frame: .zero)
		self.layer.cornerRadius = Constants.CornerRadius.small
		self.backgroundColor = UIColor.CompanionColors.primaryPlus1
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(data : GraphData) {
		loader.isHidden = false
		let graphGenerator = GraphPointGenerator(height: 100, width: Int(self.bounds.width - 10), insets: 5)
		self.stroke.setFrameSize(w: self.bounds.width, h: 100)
		if let n = data.nameLabel,
		   let tailName = data.valueTailLabel,
		   let v = data.currOverallValue,
		   let pVal = data.prevOverallValue,
		   let p = data.currPointData {
			name.text = n
			val.text = String(v) + tailName
			dif.text = graphGenerator.getDifLabelValue(valueDiff: v - pVal)
			dif.textColor = graphGenerator.getDifLabelColor(valueDiff: v - pVal)
			stroke.setPoints(points: graphGenerator.generatePoints(with: p))
			self.loader.isHidden = true
		}
	}
	
	let loader : UIActivityIndicatorView = {
		let l = UIActivityIndicatorView()
		l.hidesWhenStopped = true
		l.style = UIActivityIndicatorView.Style.medium
		l.color = UIColor.CompanionColors.textHide
		l.startAnimating()
		return l
	}()
	
	let stroke : StrokeView = {
		let s = StrokeView(strokeColor: UIColor.CompanionColors.textBlue, strokeWidth: 3)
		s.backgroundColor = UIColor.CompanionColors.primaryPlus1
		return s
	}()
	
	let name : UILabel = {
		let date = UILabel()
		date.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
		date.textColor = UIColor.CompanionColors.textHide
		return date
	}()
	
	let val : UILabel = {
		let date = UILabel()
		date.textColor = UIColor.CompanionColors.text
		date.font = date.font.withSize(11)
		return date
	}()
	
	let dif : UILabel = {
		let date = UILabel()
		date.font = date.font.withSize(11)
		return date
	}()
	
	func setupViews(){
		self.addSubview(name)
		self.addSubview(val)
		self.addSubview(dif)
		self.addSubview(stroke)
		self.addSubview(loader)
		
		loader.translatesAutoresizingMaskIntoConstraints = false
		loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		
		val.translatesAutoresizingMaskIntoConstraints = false
		val.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 2).isActive = true
		val.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		
		dif.translatesAutoresizingMaskIntoConstraints = false
		dif.topAnchor.constraint(equalTo: self.val.bottomAnchor, constant: 2).isActive = true
		dif.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		
		stroke.translatesAutoresizingMaskIntoConstraints = false
		stroke.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		stroke.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		stroke.heightAnchor.constraint(equalToConstant: 100).isActive = true
		stroke.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
	}

}

