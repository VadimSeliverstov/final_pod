//
//  Genre.swift
//  myPod
//
//  Created by Vadim on 09.06.17.
//  Copyright © 2017 Big Fish. All rights reserved.
//

import Foundation

enum Genre {
	case arts
	case comedy
	case education
	case kidsFamily
	case health
	case tvFilm
	case music
	case newsPolitics
	case religionSpirituality
	case scienceMedicine
	case sportRecreation
	case technology
	case business
	case gamesHobbies
	case societyCulture
	case governmentOrganizations
	case mostPopular
	
	var primaryGenre : String {
		switch self {
		case .arts : return "1301"
		case .comedy: return "1303"
		case .education: return "1304"
		case .kidsFamily: return "1305"
		case .health: return "1307"
		case .tvFilm: return "1309"
		case .music: return "1310"
		case .newsPolitics: return "1311"
		case .religionSpirituality: return "1314"
		case .scienceMedicine: return "1315"
		case .sportRecreation: return "1316"
		case .technology: return "1318"
		case .business: return "1321"
		case .gamesHobbies: return "1323"
		case .societyCulture: return "1324"
		case .governmentOrganizations: return "1325"
		case .mostPopular: return ""
		}
	}
	var primaryGenreDescription : String {
		switch self {
		case .arts : return "Arts"
		case .comedy: return "Comedy"
		case .education: return "Education"
		case .kidsFamily: return "Kids & Family"
		case .health: return "Health"
		case .tvFilm: return "TV & Film"
		case .music: return "Music"
		case .newsPolitics: return "News & Politics"
		case .religionSpirituality: return "Religion & Spirituality"
		case .scienceMedicine: return "Science & Medicine"
		case .sportRecreation: return "Sports & Recreation"
		case .technology: return "Technology"
		case .business: return "Business"
		case .gamesHobbies: return "Games & Hobbies"
		case .societyCulture: return "Society & Culture"
		case .governmentOrganizations: return "Government & Organizations"
		case .mostPopular: return "All"
		}
	}
	var subGenres : [String: String] {
		switch self {
		case .arts : return [
			"Food" : "1306",
			"Literature" : "1401",
			"Design" : "1402",
			"Performing Arts" : "1405",
			"Visual Arts" : "1406",
			"Fashion & Beauty" : "1459"
			]
		case .comedy: return [:]
		case .education: return [
			"K–12" : "1415",
			"Higher Education" : "1416",
			"Educational Technology" : "1468",
			"Language Courses" : "1469",
			"Training" : "1470"
			]
		case .kidsFamily: return [:]
		case .health: return [
			"Fitness & Nutrition" : "1417",
			"Self-Help" : "1420",
			"Sexuality" : "1421",
			"Alternative Health" : "1481"
			]
		case .tvFilm: return [:]
		case .music: return [:]
		case .newsPolitics: return [:]
		case .religionSpirituality: return [
			"Buddhism" : "1438",
			"Christianity" : "1439",
			"Islam" : "1440",
			"Judaism" : "1441",
			"Spirituality" : "1444",
			"Hinduism" : "1463",
			"Other" : "1464"
			]
		case .scienceMedicine: return [
			"Natural Sciences" : "1477",
			"Medicine" : "1478",
			"Social Sciences" : "1479"
			]
		case .sportRecreation: return [
			"Outdoor" : "1456",
			"Professional" : "1465",
			"College & High School" : "1466",
			"Amateur" : "1467"
			]
		case .technology: return [
			"Gadgets" : "1446",
			"Tech News" : "1448",
			"Podcasting" : "1450",
			"Software How-To" : "1480"
			]
		case .business: return [
			"Careers" : "1410",
			"Investing" : "1412",
			"Management & Marketing" : "1413",
			"Business News" : "1471",
			"Shopping" : "1472"
			]
		case .gamesHobbies: return [
			"Video Games" : "1404",
			"Automotive" : "1454",
			"Aviation" : "1455",
			"Hobbies" : "1460",
			"Other Games" : "1461"
			]
		case .societyCulture: return [
			"Personal Journals" : "1302",
			"Places & Travel" : "1320",
			"Philosophy" : "1443",
			"History" : "1462"
			]
		case .governmentOrganizations: return [
			"National" : "1473",
			"Regional" : "1474",
			"Local" : "1475",
			"Non-Profit" : "1476"
			]
		case .mostPopular: return [:]
		}
	}
}
