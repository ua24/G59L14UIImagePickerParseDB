//
//  AppDelegate.swift
//  G59L14
//
//  Created by Ivan Vasilevich on 1/23/18.
//  Copyright © 2018 RockSoft. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let config = ParseClientConfiguration { (conf) in
			conf.clientKey = "2xoHCTTW8omZxlemfUbIPTr48FRpRrwYymdcTbmz"
			conf.applicationId = "GBPXlSaaEJW9mgkj8aaEWaerdrooq6tWEUzZLy9V"
			conf.server = "https://parseapi.back4app.com"
//			conf.isLocalDatastoreEnabled = true
		}
		Parse.initialize(with: config)
		return true
	}

}

