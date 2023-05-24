//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.allowsMultipleSelection = true // Enable multiple selection in the table view
		loadItems()
	}
	
	// MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		let item = itemArray[indexPath.row]
		cell.textLabel?.text = item.title
		cell.accessoryType = item.done ? .checkmark : .none // Set the accessory type based on the item state
		
		return cell
	}
	
	// MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		saveItems()
		tableView.reloadData()
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = .none
			itemArray[indexPath.row].done = false // Update the item state to unchecked
			saveItems()
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
			itemArray.remove(at: indexPath.row)
			saveItems()
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
			if let newItemText = alert.textFields?.first?.text {
				let newItem = Item(title: newItemText, done: false)
				self?.itemArray.append(newItem)
				self?.saveItems()
				self?.tableView.reloadData()
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
		let encoder = JSONEncoder()
		if let encodedData = try? encoder.encode(itemArray) {
			UserDefaults.standard.set(encodedData, forKey: "TodoListArray")
		}
	}

	func loadItems() {
		if let encodedData = UserDefaults.standard.data(forKey: "TodoListArray") {
			let decoder = JSONDecoder()
			if let decodedData = try? decoder.decode([Item].self, from: encodedData) {
				itemArray = decodedData
			}
		}
	}
	
}
