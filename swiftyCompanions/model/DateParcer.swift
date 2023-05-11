//
//  DateParcer.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import Foundation

class DateParcer {
	static private let formatDateAndTime = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	
	static private let dateFormatter : DateFormatter = {
		let f = DateFormatter()
		f.dateFormat = formatDateAndTime
		return f
	}()
	
	static private func parseDate(from dateString : String?) -> Date? {
		guard let dateString = dateString else { return nil }
		guard let date = dateFormatter.date(from: dateString) else {return nil}
		return date
	}
	
	static func getTwoDateIntervalInMinutes(date1String : String?,date2String : String?) -> Int? {
		guard let date1 = parseDate(from: date1String),
				let date2 = parseDate(from: date2String) else { return nil }
		let interval = date1.timeIntervalSinceReferenceDate - date2.timeIntervalSinceReferenceDate
		return Int(abs(interval / 60))
	}
	
	static func getDateFromDateString(dateString : String?) -> Date? {
		return parseDate(from: dateString)
	}
	static func getStringFromDate(date : Date) -> String? {
		return dateFormatter.string(from: date)
	}
	
	static func getDateMinusMonthsAgo(monthsAgo : Int) -> Date? {
		let currentDate = Date()
		let calendar = Calendar.current
		var dateComponents = DateComponents()
		dateComponents.month = -monthsAgo
		let newDate = calendar.date(byAdding: dateComponents, to: currentDate)
		return newDate
	}
	
}
