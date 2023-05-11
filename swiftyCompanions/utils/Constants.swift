//
//  Constants.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation
import UIKit

struct Constants {

	struct apiData {
		static let urlBase = "api.intra.42.fr"
		static let urlFullGetToken = "/oauth/token"
		static let urlFullGetUsers = "/v2/users/"
		static let urlFullGetLanguages = "/v2/languages"
		static let urlTailGetScaleTeamAsCorrector = "/scale_teams/as_corrector"
		static let urlTailGetTeams = "/teams"
		static let urlTailGetLocations = "/locations"
	}
	
	struct CornerRadius {
		static let standart = UIScreen.main.bounds.width/35
		static let small = UIScreen.main.bounds.width/40
	}
	
	static public let languages : Dictionary<Int,String> = {
		var l  = Dictionary<Int,String>()
		l[21] = "german"
		l[20] = "dutch"
		l[19] = "catalan"
		l[18] = "turkish"
		l[17] = "brazilian portuguese"
		l[16] = "italian"
		l[15] = "armenian"
		l[14] = "korean"
		l[13] = "japanese"
		l[11] = "spanish"
		l[9] = "portuguese"
		l[6] = "russian"
		l[5] = "ukrainian"
		l[3] = "romanian"
		l[2] = "english"
		l[1] = "français"
		return l
	}()
	
	static public let cellWidth = UIScreen.main.bounds.width - UIScreen.main.bounds.width/15
}
