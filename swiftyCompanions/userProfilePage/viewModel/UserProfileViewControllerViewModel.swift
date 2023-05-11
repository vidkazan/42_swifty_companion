//
//  UserProfileViewControllerViewModel.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation
import UIKit
import DequeModule


class UserProfileViewControllerViewModel {
	let user				: UserModel
	var projects			: [UserProfileProjectCellData]	= []
	var requestsGgroupIdentifier : String
	var userKind			: Kind 							= .student
	weak var searchViewModel : SearchUserViewControllerViewModel?
	var loginGraphData		= GraphData(
		nameLabel: "Login time last month",
		   valueTailLabel: "h",
		   prevOverallValue: nil,
		   currOverallValue: nil,
		currPointData: nil
	   )
	var loginEvalData = GraphData(
		nameLabel: "Evaluations last month",
		   valueTailLabel: "",
		   prevOverallValue: nil,
		   currOverallValue: nil,
		currPointData: nil
	   )
	
	var onGraphData: (() -> Void)?
	
	func onProfileViewWillDisAppear (){
		UserService.cancelAllOngoingRequests()
	}
	
	init(_ user : UserModel, requestsGgroupIdentifier : String, searchVM : SearchUserViewControllerViewModel?){
		self.requestsGgroupIdentifier = requestsGgroupIdentifier
		self.user = user
		self.loadImage()
		self.searchViewModel = searchVM
		setKind()
		analyseProjects()
		fetchLocations()
		fetchEvals()
	}
	
	func setKind(){
		if user.isStaff == true {
			self.userKind = .admin
		} else if self.getCursus()?.cursus.name == "42cursus" {
			self.userKind = .student
		} else {
			self.userKind = .piscine
		}
	}
}
