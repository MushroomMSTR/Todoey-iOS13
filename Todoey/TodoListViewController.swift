//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	let itemArray = ["Learn Swift", "Read a book", "Buy new course"]
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
//	// MARK: - Navigation Controller - Navigation Bar - Bar tint
//
//	override func viewWillAppear(_ animated: Bool) {
//		   super.viewWillAppear(animated)
//		   navigationController?.navigationBar.prefersLargeTitles = true
//
//		   let appearance = UINavigationBarAppearance()
//		   appearance.backgroundColor = .systemBlue
//		   appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//		   appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//		   navigationController?.navigationBar.tintColor = .white
//		   navigationController?.navigationBar.standardAppearance = appearance
//		   navigationController?.navigationBar.compactAppearance = appearance
//		   navigationController?.navigationBar.scrollEdgeAppearance = appearance
//   }
	
	// MARK: - TableView Datasource Methods

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	// MARK: - TableView Delegate Methods

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			if cell.accessoryType == .checkmark {
				cell.accessoryType = .none
			} else {
				cell.accessoryType = .checkmark
			}
		}
		tableView.deselectRow(at: indexPath, animated: true)
		
		// Handle row selection logic here
	}

	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		// Handle accessory button tap logic here
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		// Return the desired height for rows in the table view
		return 44
	}

	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// Perform custom cell configuration or animation before the cell is displayed
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return true if the row at the specified index path can be edited (e.g., delete or move)
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Handle row deletion logic here
		}
	}
}
