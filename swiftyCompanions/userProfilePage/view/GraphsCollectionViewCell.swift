//
//  GraphCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class GraphsCollectionViewCell: UICollectionViewCell {
	static let identifier = "GraphsCollectionViewCell"
	var leftGraph = GraphView()
	var rightGraph = GraphView()
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// x range : 5 to 150 for width 150
	// y range : 95 to 5 for heiht 100
	func configure(with data : UserProfileGraphsCellData){
		leftGraph.configure(data : data.loginGraphData)
		rightGraph.configure(data : data.evalsGraphData)
	}
	
	func setupViews(){
		self.layer.cornerRadius = Constants.CornerRadius.standart
		self.backgroundColor = UIColor.CompanionColors.secondary
		
		addSubview(leftGraph)
		addSubview(rightGraph)
		
		leftGraph.translatesAutoresizingMaskIntoConstraints = false
		leftGraph.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
		leftGraph.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		leftGraph.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		leftGraph.trailingAnchor.constraint(equalTo: self.centerXAnchor,constant: -5).isActive = true
		
		rightGraph.translatesAutoresizingMaskIntoConstraints = false
		rightGraph.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
		rightGraph.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		rightGraph.leadingAnchor.constraint(equalTo: self.centerXAnchor,constant: 5).isActive = true
		rightGraph.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}
