//
//  ViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

extension SearchUserViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
	func collectionView(_ : UICollectionView, numberOfItemsInSection: Int) -> Int {
		switch self.viewModel.state {
		case .onNewData:
			return self.viewModel.searchUsersData.count > 0 ? self.viewModel.searchUsersData.count : 1
		case .onProfilePage, .onLoading:
			return 0
		case .onError :
			return 0
		case .onStart:
			return 0
		}
	}
	func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
		switch self.viewModel.state {
		case .onNewData:
			if self.viewModel.searchUsersData.count > 0 {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
				cell.configure(with: viewModel.searchUsersData[indexPath.row])
				return cell
			} else {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchEmptyResultCell.identifier, for: indexPath) as! SearchEmptyResultCell
				cell.configure(description: "No users found")
				return cell
			}
		case .onProfilePage, .onLoading,.onStart, .onError:
			return UICollectionViewCell()
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: collectionView.frame.width - collectionView.frame.width/11, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = self.collectionView.cellForItem(at: indexPath) as? SearchResultCell else {
			return
		}
		let dataUser = viewModel.searchUsersData[indexPath.row]
		prints("tap ", dataUser.login!)
		cell.selectCell()
		viewModel.fetchUser(userId: dataUser.id, requestsGgroupIdentifier: String(Date.now.timeIntervalSince1970), cellIndexPath: indexPath)
	}
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.alpha = 0
		cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		
		UIView.animate(withDuration: 0.25) {
			cell.alpha = 1
			cell.transform = .identity
		}
	}
	func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.alpha = 1
		cell.transform = .identity
		
		UIView.animate(withDuration: 0.25) {
			cell.alpha = 0
			cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
