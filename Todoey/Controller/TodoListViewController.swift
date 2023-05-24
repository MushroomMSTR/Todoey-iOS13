//
//  TodoListViewController.swift
//  Todoey
//
//  Created by NazarStf on 23.05.2023.
//

import UIKit

class TodoListViewController: UITableViewController {
	
	private var dataModel = DataModel()
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Persistent Local Data Storage Using plist
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		tableView.allowsMultipleSelection = true // Enable multiple selection in the table view
	}
	
	// MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataModel.getItems().count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		let item = dataModel.getItems()[indexPath.row]
		cell.textLabel?.text = item.title
		cell.accessoryType = item.done ? .checkmark : .none // Set the accessory type based on the item state
		
		return cell
	}
	
	// MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = dataModel.getItems()[indexPath.row]
			let updatedItem = Item(title: item.title, done: !item.done)
			dataModel.updateItem(at: indexPath.row, withUpdatedItem: updatedItem)
			cell.accessoryType = updatedItem.done ? .checkmark : .none
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = .none
			let item = dataModel.getItems()[indexPath.row]
			let updatedItem = Item(title: item.title, done: false)
			dataModel.updateItem(at: indexPath.row, withUpdatedItem: updatedItem)
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
			dataModel.deleteItem(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
			if let newItemText = alert.textFields?.first?.text {
				let newItem = Item(title: newItemText, done: false)
				self?.dataModel.addItem(newItem)
				self?.tableView.reloadData()
			}
		}
		
		alert.addTextField { alertTextField in
			alertTextField.placeholder = "Create new item"
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
}
