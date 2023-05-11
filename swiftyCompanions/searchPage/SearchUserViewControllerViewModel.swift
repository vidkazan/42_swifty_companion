//
//  SearchViewControllerViewModel.swift.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation

enum SearchControllerStates {
	case onStart
	case onLoading
	case onNewData
	case onError(error : UserServiceError, indexPath : IndexPath?)
	case onProfilePage(userModel : UserModel, indexPath : IndexPath, requestGroupId : String)
	
	var description : String {
		switch self {
		case .onStart:
			return "onStart"
		case .onLoading:
			return "onLoading"
		case .onNewData:
			return "onNewData"
		case .onError:
			return "onError"
		case .onProfilePage:
			return "onProfilePage"
		}
	}
}

class SearchUserViewControllerViewModel {
	var onStateChange : ((SearchControllerStates) -> Void)?
	
	var state : SearchControllerStates {
		didSet {
			prints("state: ",state.description)
			self.onStateChange?(self.state)
		}
	}
	var previousSearchLineString = ""
	
	var searchUsersData : [UserSearchJSON] = [] {
		didSet {
			self.state = .onNewData
		}
	}

	init(){
		self.state = .onStart
	}
	
	func updateSearchText(text : String?){
		guard let text = text else { return }
		if text.count > 0, text.count > self.previousSearchLineString.count {
			prints(text)
			self.state = .onLoading
			fetchUsers(filter: text)
		}
		self.previousSearchLineString = text
	}
}


