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

class AddPhotoVC: UIViewController {
	
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
	
}

extension AddPhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		print(info)
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
			loginVC.delegate = self
			loginVC.signUpController?.delegate = self
			//			loginVC.de
			present(loginVC, animated: true, completion: nil)
		}}
	
}

extension AddPhotoVC: PFSignUpViewControllerDelegate {
	
	func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
		log(PFLogInViewController(), didLogIn: user)
	}
}
