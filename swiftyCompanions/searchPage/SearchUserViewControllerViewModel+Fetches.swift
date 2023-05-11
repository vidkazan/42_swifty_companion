//
//  SearchViewControllerViewModel.swift.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation

extension SearchUserViewControllerViewModel {
	func fetchUsers(filter : String?){
		guard let filterUnwrapped = filter, !filterUnwrapped.isEmpty,
		   let query = Query.getQueryItems(methods: [
				Query.page(size: 10),
				Query.range(range: QueryRange.login(login: filterUnwrapped))
			]) else {
				self.state = .onError(error: .clientKeysError, indexPath: nil)
				return
			}
		UserService.fetch([UserSearchJSON].self,query: query, type: UserService.Requests.getUsers,requestGroupId: "") { [self] result in
			switch result {
			case .success(let res) :
				self.searchUsersData = res
			case .failure(let error) :
				self.state = .onError(error: error, indexPath: nil)
			}
		}
	}
	
	func fetchUser(userId : Int, requestsGgroupIdentifier : String, cellIndexPath : IndexPath){
		UserService.fetch(UserModel.self,query: [], type: UserService.Requests.getUser(userId: userId),requestGroupId: requestsGgroupIdentifier) { [self] result in
			switch result {
			case .success(let res) :
				self.state = .onProfilePage(userModel:res, indexPath: cellIndexPath, requestGroupId: requestsGgroupIdentifier)
			case .failure(let error) :
				self.state = .onError(error: error, indexPath: cellIndexPath)
			}
		}
	}
}


