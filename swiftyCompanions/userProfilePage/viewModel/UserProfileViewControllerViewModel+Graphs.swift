//
//  UserProfileViewControllerViewModel.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation
import UIKit
import DequeModule


extension UserProfileViewControllerViewModel {
	func fetchLocations() {
		self.fetchLocationSessions(from: 1, to: 0, loginSessionAnalyseType: .perDayAndSum)
		self.fetchLocationSessions(from: 2, to: 1, loginSessionAnalyseType: .onlySum)
	}
	
	func fetchEvals() {
		self.fetchScaleTeams(from: 1, to: 0, loginSessionAnalyseType: .perDayAndSum)
		self.fetchScaleTeams(from: 2, to: 1, loginSessionAnalyseType: .onlySum)
	}
	
	func fetchLocationSessions(from monthsFrom: Int, to monthsTo: Int, loginSessionAnalyseType: LoginSessionAnalyseType){
		guard let from = DateParcer.getDateMinusMonthsAgo(monthsAgo: monthsFrom) else { return }
		guard let to = DateParcer.getDateMinusMonthsAgo(monthsAgo: monthsTo) else { return }
		guard let query = Query.getQueryItems(methods: [
			Query.page(size: 100),
			Query.range(range: QueryRange.beginAt(dateFrom: from, dateTo: to))
		]) else {
			print("Query getting error get locations")
			return
		}
		UserService.fetch([LoginSession].self, query: query, type: UserService.Requests.getLocations(userId: self.user.id), requestGroupId : self.requestsGgroupIdentifier) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let locations) :
				self.analyseLoginSessions(loginSessions: locations,type: loginSessionAnalyseType)
			case .failure(let error) :
				break
			}
		}
	}

	func fetchScaleTeams(from monthsFrom: Int, to monthsTo: Int, loginSessionAnalyseType: LoginSessionAnalyseType){
		guard let from = DateParcer.getDateMinusMonthsAgo(monthsAgo: monthsFrom) else { return }
		guard let to = DateParcer.getDateMinusMonthsAgo(monthsAgo: monthsTo) else { return }
		guard let query = Query.getQueryItems(methods: [
			Query.page(size: 100),
			Query.range(range: QueryRange.beginAt(dateFrom: from, dateTo: to))
		]) else {
			print("Query getting error get scale teams")
			return
		}
		UserService.fetch([ScaleTeam].self, query: query, type: UserService.Requests.getScaleTeamsAsCorrector(userId: self.user.id),requestGroupId: requestsGgroupIdentifier) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let scaleTeams) :
				self.analyseScaleTeamSessions(evalSessions: scaleTeams, type: loginSessionAnalyseType)
			case .failure(let error) :
				break
			}
		}
	}
	
	func analyseScaleTeamSessions(evalSessions : [ScaleTeam], type : LoginSessionAnalyseType){
		let totalMonthDuration = evalSessions.count
		switch type {
			case .perDayAndSum:
				var points = (0 ..< 32).map { ($0,0) }
			guard let minimumDate = DateParcer.getDateMinusMonthsAgo(monthsAgo: 1) else { return }
				
				for session in evalSessions {
					let date = DateParcer.getDateFromDateString(dateString: session.filledAt)
					if	let date = date,
						let day = Calendar.current.dateComponents([.day], from: minimumDate, to: date).day {
							points[day].1 =  points[day].1 + 1
					}
				}
				self.loginEvalData.currOverallValue = totalMonthDuration
				self.loginEvalData.currPointData =  points
		case .onlySum:
				self.loginEvalData.prevOverallValue =  totalMonthDuration
			}
		self.onGraphData?()
	}
	
	func analyseLoginSessions(loginSessions : [LoginSession], type : LoginSessionAnalyseType){
		var totalMonthDuration : Int = 0
		switch type {
		case .perDayAndSum:
			var points = (0 ..< 32).map { ($0,0) }
			guard let minimumDate = DateParcer.getDateMinusMonthsAgo(monthsAgo: 1) else { return }
			for session in loginSessions {
				let date = DateParcer.getDateFromDateString(dateString: session.beginAt)
				if
					let date = date,
					let duration = DateParcer.getTwoDateIntervalInMinutes(
						date1String: session.beginAt,
						date2String: session.endAt),
					let day = Calendar.current.dateComponents([.day], from: minimumDate, to: date).day {
					totalMonthDuration = totalMonthDuration + duration
					points[day + 1].1 = duration
				}
			}
			self.loginGraphData.currOverallValue = totalMonthDuration / 60
			self.loginGraphData.currPointData =  points
		case .onlySum:
			for session in loginSessions {
				if let duration = DateParcer.getTwoDateIntervalInMinutes(
					date1String: session.beginAt,
					date2String: session.endAt) {
					totalMonthDuration = totalMonthDuration + duration
				}
			}
			self.loginGraphData.prevOverallValue =  totalMonthDuration / 60
		}
		self.onGraphData?()
	}
	
	func getGraphsCellData() -> UserProfileGraphsCellData {
		return UserProfileGraphsCellData(
			loginGraphData: self.loginGraphData,
			evalsGraphData: self.loginEvalData
		)
	}
}
