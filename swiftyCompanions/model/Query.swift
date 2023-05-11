//
//  Query.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import Foundation

enum Query{
	case range(range : QueryRange)
	case page(size : Int)
	case grantType
	case clientId
	case clientSecret
	
	
	func getKeyDataFromPlist() -> (id : String,secret : String)? {
		guard let plistPath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
			print("Unable to find plist file.")
			return nil
		}

		// Load the contents of the plist file into a dictionary
		guard let plistData = NSDictionary(contentsOfFile: plistPath) else {
			print("Unable to read plist file.")
			return nil
		}

		// Access the data from the plist dictionary
		if let client_id = plistData["client_id"] as? String,
		   let client_secret = plistData["client_secret"] as? String {
			return (client_id,client_secret)
		} else {
			print("Value not found or invalid format in plist.")
			return nil
		}
	}
	
	func getQueryMethod() -> URLQueryItem? {
		guard let keys = getKeyDataFromPlist() else { return nil }
		switch self {
		case .range(let range):
			return range.getRange()
		case .page(let size):
			if size > 9, size < 101 {
				return URLQueryItem(name: "page[size]", value: String(size))
			} else {
				return URLQueryItem(name: "page[size]", value: String(30))
			}
		case .grantType:
				return URLQueryItem(name: "grant_type", value: "client_credentials")
		case .clientId:
//				return URLQueryItem(name: "client_id", value: Constants.apiData.clientId)
			return URLQueryItem(name: "client_id", value: keys.id)
		case .clientSecret:
//				return URLQueryItem(name: "client_secret", value: Constants.apiData.clientSecret)
			return URLQueryItem(name: "client_secret", value: keys.secret)
		}
	}
	
	static func getQueryItems(methods : [Query]) -> [URLQueryItem]? {
		var items : [URLQueryItem] = []
		for method in methods {
			guard let m = method.getQueryMethod() else { return nil }
			items.append(m)
		}
//		let items = methods.map { $0.getQueryMethod() }
		return items
	}
}

enum QueryRange{
	case beginAt(dateFrom: Date,dateTo: Date)
	case login(login : String)
	
	var queryPrefix : String {
		switch self {
		case .beginAt:
			return "range[begin_at]"
		case .login:
			return "range[login]"
		}
	}
	func getRange() -> URLQueryItem {
		switch self {
		case .beginAt(let date1, let date2):
			let value = "\(DateParcer.getStringFromDate(date: date1) ?? ""),\(DateParcer.getStringFromDate(date: date2) ?? "")"
			return URLQueryItem(name: self.queryPrefix, value: value)
		case .login(let login):
			let value = "\(login.lowercased()),\(login.lowercased())z"
			return URLQueryItem(name: self.queryPrefix, value: value)
		}
	}
}
