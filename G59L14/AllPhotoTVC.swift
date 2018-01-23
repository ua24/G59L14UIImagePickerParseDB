//
//  AllPhotoTVC.swift
//  G59L14
//
//  Created by Ivan Vasilevich on 1/23/18.
//  Copyright © 2018 RockSoft. All rights reserved.
//

import UIKit
import Parse

class AllPhotoTVC: UITableViewController {
	
	@IBOutlet weak var refreshSpinner: UIRefreshControl!
	var objectsForTableView = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

		let nib = UINib(nibName: "PhotoTVCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "photoCell")
		
		loadPhotos()
    }

	func loadPhotos() {
		let query = PFQuery(className: "Photo")
		query.findObjectsInBackground { (objects, error) in
			if let unwrappedObjects = objects {
				self.objectsForTableView  = unwrappedObjects
				self.tableView.reloadData()
				self.refreshSpinner.endRefreshing()
			}
			else {
				print(error!)
			}
		}
	}
	
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectsForTableView.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTVCell

        // Configure the cell...
		let obj = objectsForTableView[indexPath.row]
		if let file = obj["image"] as? PFFile {
			cell.imageBox.file = file
			cell.imageBox.load(inBackground: { (image, error) in
				cell.imageBox.image = image
			})
		}
		
		
        return cell
    }


	@IBAction func refreshPushed(_ sender: UIRefreshControl) {
		loadPhotos()
	}
	
}
