//
//  ApiManager.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import Foundation
import UIKit
import DequeModule

enum UserServiceError: Error {
	case badUrl
	case cannotConnectToHost(string : String)
	case badServerResponse(code : Int)
	case cannotDecodeRawData
	case cannotDecodeContentData
	case unauthorised
	case badRequest
	case requestRateExceeded
	case clientKeysError
	
	
	
	var description : String  {
		switch self {
		case .badUrl:
			return "Bad url"
		case .cannotConnectToHost(let string):
			return string
		case .badServerResponse(let code):
			return "Bad server response \(code)"
		case .cannotDecodeRawData:
			return "Server response data nil"
		case .cannotDecodeContentData:
			return "Server response data decoding"
		case .unauthorised:
			return "Your token is expired"
		case .badRequest:
			return "Bad search request"
		case .requestRateExceeded:
			return "Request rate exceeded"
		case .clientKeysError:
			return "Client id/secret error"
		}
	}
}

class UserService  {
	private static var set : [(Int, URLSessionDataTask?)] = (0 ..< 6).map { ($0,nil) }
	private static var currentRequestGroupId : String = ""
	private static var token : String =  ""
	private static let queue = DispatchQueue(label: "com.fcody.swifty_companions.testQueue", qos: .utility)
	private static var fetchLobbyDeque = Deque<((type : String, query : String), function : (()->Void))>()
	
	enum Requests {
		case getUser(userId : Int)
		case getUsers
		case getToken
		case getLocations(userId : Int)
		case getScaleTeamsAsCorrector(userId : Int)
		case customGet(path : String)
		
		var description : String {
			switch self {
			case .getUser:
				return "getUser"
			case .getUsers:
				return "getUsers"
			case .getToken:
				return "getToken"
			case .getLocations:
				return "getLocations"
			case .getScaleTeamsAsCorrector:
				return "getScaleTeams"
			case .customGet:
				return "customGet"
			}
		}
		
		var index : Int {
			switch self {
			case .getUser:
				return 0
			case .getUsers:
				return 1
			case .getToken:
				return 2
			case .getLocations:
				return 3
			case .getScaleTeamsAsCorrector:
				return 4
			case .customGet:
				return 5
			}
		}
		
		var method : String {
			switch self {
			case .getToken:
				return "POST"
			case .getUsers, .getUser, .customGet, .getLocations, .getScaleTeamsAsCorrector:
				return "GET"
			}
		}
		
		var headers : [(value : String, key : String)] {
			switch self {
			case .getToken:
				return []
			case .getUsers, .getUser, .customGet, .getLocations, .getScaleTeamsAsCorrector:
				return [("Bearer \(UserService.token)","Authorization")]
			}
		}
		
		var urlString : String {
			switch self {
				case .getToken:
					return Constants.apiData.urlFullGetToken
				case .getUsers:
					return Constants.apiData.urlFullGetUsers
				case .getUser(let userId):
					return Constants.apiData.urlFullGetUsers + String(userId)
				case .getLocations(let userId):
					return Constants.apiData.urlFullGetUsers + String(userId) + Constants.apiData.urlTailGetLocations
				case .getScaleTeamsAsCorrector(let userId):
					return Constants.apiData.urlFullGetUsers + String(userId) + Constants.apiData.urlTailGetScaleTeamAsCorrector
				case .customGet(let path):
					return path
			}
		}
		
		func getRequest(urlEndPoint : URL) -> URLRequest {
			switch self {
			case .getUser, .getUsers, .getToken, .customGet, .getLocations, .getScaleTeamsAsCorrector:
				var req = URLRequest(url : urlEndPoint)
				req.httpMethod = self.method
				for header in self.headers {
					req.addValue(header.value, forHTTPHeaderField: header.key)
				}
				return req
			}
		}
	}
	
	static func cancelAllOngoingRequests(){
		self.fetchLobbyDeque.removeAll()
	}
	static func updateToken() throws {
		guard let query =  Query.getQueryItems(methods: [.grantType,.clientId,.clientSecret]) else {
			print("query error updateToken")
			throw UserServiceError.clientKeysError
		}
		fetch(
			TokenDataJSON.self,
			query: query,
			type: UserService.Requests.getToken,
			requestGroupId: ""
		) { result in
			switch result {
			case .success(let res):
				guard let token = res.access_token,
					  let exp = res.expires_in else {return}
				self.token = token
				prints("token expires in \(exp)")
				DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(exp)) {
					do {
						try self.updateToken()
					}
					catch {
						return
					}
				}
			case .failure(let error):
				break
			}
		}
	}
	
	static func fetch<T : Decodable>(
		_ t : T.Type,
		query : [URLQueryItem],
		type : Requests,
		requestGroupId : String,
		completed: @escaping (Result<T, UserServiceError>) -> Void) {
		switch type {
		case .customGet,.getToken:
			queue.async {
				execute(
					T.self,
					query: query,
					type: type,
					completed: completed
				)
			}
		default:
			switch type {
			case .getUser:
				currentRequestGroupId = requestGroupId
				break
			default:
				break
			}
			fetchLobbyDeque.append((
				(type.description, requestGroupId),
				{
					execute(
					T.self,
					query: query,
					type: type,
					completed: completed
				)
			}))
//			DispatchQueue.main.async {
				queue.async {
					while !fetchLobbyDeque.isEmpty {
						let task = self.fetchLobbyDeque.popFirst()
						switch type {
						case .getUser, .getUsers,.getToken:
							if let t = set[type.index].1 {
								prints("previous is cancelled by type")
								t.cancel()
							}
						case .getLocations, .getScaleTeamsAsCorrector, .customGet:
							break
						}
						switch type {
						case .getUsers, .getUser:
							if fetchLobbyDeque.contains(where: { $0.0.type == task?.0.type }) {
								prints(task?.0.type.description ?? "", task?.0.query ?? "", "DROPPED by type")
							} else {
								if !set.filter( { $0.1 != nil } ).isEmpty {
									prints(task?.0.type.description ?? "", task?.0.query ?? "", "waiting")
									usleep(500000)
								}
								prints(task?.0.type.description ?? "", task?.0.query ?? "", "starting")
								task?.function()
								prints(task?.0.type.description ?? "", task?.0.query ?? "")
							}
							return
						case .getScaleTeamsAsCorrector, .getLocations:
							if task?.0.query != currentRequestGroupId {
								prints(task?.0.type.description ?? "", task?.0.query ?? "", "DROPPED by groupId")
							} else {
								prints(task?.0.type.description ?? "", task?.0.query ?? "", "waiting")
								usleep(500000)
								prints(task?.0.type.description ?? "", task?.0.query ?? "", "starting")
								task?.function()
								prints(task?.0.type.description ?? "", task?.0.query ?? "")
							}
							return
						default:
							prints(task?.0.type.description ?? "", task?.0.query ?? "", "waiting")
							usleep(500000)
							prints(task?.0.type.description ?? "", task?.0.query ?? "", "starting")
							task?.function()
							prints(task?.0.type.description ?? "", task?.0.query ?? "")
						}
					}
				}
			}
//		}
	}
	
	static private func execute<T : Decodable>(_ t : T.Type,query : [URLQueryItem], type : Requests,completed: @escaping (Result<T, UserServiceError>) -> Void) {
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = 5.0
		let session = URLSession(configuration: sessionConfig)
		
		let url : URL? = {
			switch type {
			case .getUser, .getUsers, .getToken, .getLocations, .getScaleTeamsAsCorrector:
				var components = URLComponents()
				components.path = {
					switch type {
					case .getUser, .getUsers, .getToken, .getLocations, .getScaleTeamsAsCorrector:
						return type.urlString
					case .customGet(let path):
						return path
					}
				}()
				components.host = Constants.apiData.urlBase
				components.scheme = "https"
				components.queryItems = query
				return components.url
			case .customGet(let path):
				return URL(string: path)
			}
		}()
		guard let url = url else {
			completed(.failure(.badUrl))
//			print(">",Date.now.timeIntervalSince1970,type.description ,query)
			set[type.index].1 = nil
			return
		}
		let request = type.getRequest(urlEndPoint: url)
		let task = session.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if let error = error as? URLError {
					switch error.code.rawValue  {
					case -999:
						break
					default:
						completed(.failure(.cannotConnectToHost(string: error.localizedDescription)))
					}
//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Connect to HOST")
					set[type.index].1 = nil
					return
				}
				
				guard let response = response as? HTTPURLResponse  else {
					completed(.failure(.cannotDecodeRawData))
//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Bad Response")
					set[type.index].1 = nil
					return
				}
				
				switch response.statusCode {
					case 401:
						completed(.failure(.unauthorised))
	//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Bad Response")
						set[type.index].1 = nil
						return
					case 400:
						completed(.failure(.badRequest))
	//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Bad Response")
						set[type.index].1 = nil
						return
					case 429:
					completed(.failure(.requestRateExceeded))
	//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Bad Response")
						set[type.index].1 = nil
						return
					case 200:
						break
					default:
						completed(.failure(.badServerResponse(code: response.statusCode)))
//						print(">",Date.now.timeIntervalSince1970,type.description,query,"error Bad Response")
						set[type.index].1 = nil
						return
				}
				guard let data = data else {
					completed(.failure(.cannotDecodeRawData))
//					print(">",Date.now.timeIntervalSince1970,type.description,query,"error Get Data")
					set[type.index].1 = nil
					return
				}
				switch type {
				case .getUser, .getUsers, .getToken, .getLocations, .getScaleTeamsAsCorrector:
					let decoder = JSONDecoder()
					do {
						let decodedData = try decoder.decode(T.self, from: data)
						completed(.success(decodedData))
						prints(type.description,query,"finished")
						set[type.index].1 = nil
						break
					} catch {
						completed(.failure(.cannotDecodeContentData))
//						print(type.description,query,"error Decode JSON")
						set[type.index].1 = nil
						return
					}
				case .customGet:
					completed(.success(data as! T))
					set[type.index].1 = nil
				}
			}
		}
		
		switch type {
		case .getUser,.getUsers,.getToken,.getLocations,.getScaleTeamsAsCorrector:
			set[type.index].1 = task
		case .customGet:
			break
		}
		task.resume()
		return
	}
}
