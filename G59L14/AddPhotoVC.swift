//
//  AddPhotoVC.swift
//  G59L14
//
//  Created by Ivan Vasilevich on 1/23/18.
//  Copyright © 2018 RockSoft. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import FBSDKLoginKit


class AddPhotoVC: UIViewController {
	
	@IBOutlet weak var uploadButton: UIButton!
	@IBOutlet weak var previewImageBox: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkLogin()
	}
	
	@IBAction func addPhotoPressed(_ sender: UIBarButtonItem) {
		let picker = UIImagePickerController()
		picker.delegate = self
		//		picker.sourceType = .camera
		present(picker, animated: true, completion: nil)
		
	}
	
	@IBAction func uploadButtonPressed(_ sender: UIButton) {
		sender.isEnabled = false
		//
		let photoObj = PFObject(className: "Photo")
		if let image = previewImageBox.image {
			if let data = UIImageJPEGRepresentation(image, 0.5) {
				var name = "photo\((Date().description as NSString).replacingOccurrences(of: "-", with: " ")).jpg"
				name = "photo\(data.count).jpg"
				print(name)
				let file = PFFile(name:name, data:data)
				file?.saveInBackground(block: { (success, error) in
					if success {
						photoObj["image"] = file
						photoObj["user"] = PFUser.current()!
						photoObj.saveEventually({ (success, error) in
							if !success {
								print(error!)
							}
							else {
								print("your image saved - check DB")
								self.previewImageBox.image = nil
							}
						})
					}
				})
			}
		}
	}

	@IBAction func logoutPressed(_ sender: UIBarButtonItem) {
		PFUser.logOut()
		checkLogin()
	}
	
}

extension AddPhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		uploadButton.isEnabled = true
		dismiss(animated: true, completion: nil)
		previewImageBox.image = info[UIImagePickerControllerOriginalImage] as? UIImage
	}
}

extension AddPhotoVC: PFLogInViewControllerDelegate {
	
	func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
		print("welcome", user.username!)
		navigationItem.title = user.username!
		dismiss(animated: true, completion: nil)
	}
	
	func checkLogin() {
		
		if let currentUser = PFUser.current() {
			log(PFLogInViewController(), didLogIn: currentUser)
		}
		else {
			// Show the signup or login screen
			let loginVC = PFLogInViewController()
			let facebookLoginButton = FBSDKLoginButton()
			facebookLoginButton.frame.origin = CGPoint(x: 20, y: 20)
//			facebookLoginButton.setTitle("Login with facebook", for: .normal)
//			facebookLoginButton.setTitle("", for: .highlighted)
//
//			facebookLoginButton.addTarget(self, action: #selector(showFacebookLogin(from:)), for: .touchUpInside)
//			facebookLoginButton.backgroundColor = .red
//			let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//			fbLoginManager.loginBehavior = FBSDKLoginBehavior.Web
//			fbLoginManager.logInWithReadPermissions(["public_profile","email"], fromViewController: self) { (result, error) -> Void in
//				if error != nil {
//					print(error.localizedDescription)
//					self.dismissViewControllerAnimated(true, completion: nil)
//				} else if result.isCancelled {
//					print("Cancelled")
//					self.dismissViewControllerAnimated(true, completion: nil)
//				} else {
//
//				}
//			}
			
			
			facebookLoginButton.delegate = self
			loginVC.view.addSubview(facebookLoginButton)
			loginVC.delegate = self
			loginVC.signUpController?.delegate = self
			//			loginVC.de
			present(loginVC, animated: true, completion: nil)
		}
	}
	
	
	@objc func showFacebookLogin(from viewController: UIViewController) {
		print("fb button pressed")
		
	}
	
}


extension AddPhotoVC: PFSignUpViewControllerDelegate {
	
	func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
		log(PFLogInViewController(), didLogIn: user)
	}
}

extension AddPhotoVC: FBSDKLoginButtonDelegate {
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status"]).start { (connection, anyShit, error) in
			print(connection)
			print(anyShit)
			let id = (anyShit as! [String : Any])["id"] as! String
			print(id)
		}

	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		
	}

}
