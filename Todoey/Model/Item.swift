//
//  Item.swift
//  Todoey
//
//  Created by NazarStf on 24.05.2023.
//

import Foundation

struct Item: Codable {
	var title: String
	var done: Bool
}

class DataModel {
	private let plistURL: URL = {
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			fatalError("Unable to retrieve documents directory.")
		}
		return documentsDirectory.appendingPathComponent("TodoList.plist")
	}()
	
	private var items: [Item] = []
	
	init() {
		loadItems()
	}
	
	func getItems() -> [Item] {
		return items
	}
	
	func addItem(_ newItem: Item) {
		items.append(newItem)
		saveItems()
	}
	
	func deleteItem(at index: Int) {
		items.remove(at: index)
		saveItems()
	}
	
	func updateItem(at index: Int, withUpdatedItem updatedItem: Item) {
		items[index] = updatedItem
		saveItems()
	}
	
	private func saveItems() {
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(items)
			try data.write(to: plistURL)
		} catch {
			fatalError("Unable to encode and save data: \(error)")
		}
	}
	
	private func loadItems() {
		do {
			let data = try Data(contentsOf: plistURL)
			let decoder = PropertyListDecoder()
			items = try decoder.decode([Item].self, from: data)
		} catch {
			print("Error loading data: \(error)")
		}
	}
}
