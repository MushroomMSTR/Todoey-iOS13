//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Persistent Local Data Storage Using UserDefaults
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		tableView.allowsMultipleSelection = true // Enable multiple selection in the table view
		loadItems()
	}
	
	// MARK: - TableView Datasource Methods

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Item.itemArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		cell.textLabel?.text = Item.itemArray[indexPath.row]
		cell.accessoryType = Item.itemStates[indexPath.row] ? .checkmark : .none // Set the accessory type based on the item state

		return cell
	}
	
	// MARK: - TableView Delegate Methods

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
			Item.itemStates[indexPath.row] = (cell.accessoryType == .checkmark) ? true : false
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}

	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = .none
			Item.itemStates[indexPath.row] = false // Update the item state to unchecked
		}
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
			Item.itemArray.remove(at: indexPath.row)
			Item.itemStates.remove(at: indexPath.row)
			saveItems()
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

		let action = UIAlertAction(title: "Add Item", style: .default) { action in
			if let newItemText = alert.textFields?.first?.text {
				Item.itemArray.append(newItemText)
				Item.itemStates.append(false) // Set the initial state of the new item as unchecked
				self.saveItems()
				self.tableView.reloadData()
			}
		}

		alert.addTextField { alertTextField in
			alertTextField.placeholder = "Create new item"
		}

		alert.addAction(action)

		present(alert, animated: true, completion: nil)
	}
	
	// MARK: - Data Persistence

	func saveItems() {
		UserDefaults.standard.set(Item.itemArray, forKey: "TodoListArray")
		UserDefaults.standard.set(Item.itemStates, forKey: "TodoListStates")
	}

	func loadItems() {
		if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [String] {
			Item.itemArray = items
		}
		if let states = UserDefaults.standard.array(forKey: "TodoListStates") as? [Bool] {
			Item.itemStates = states
		}
	}
	
}
