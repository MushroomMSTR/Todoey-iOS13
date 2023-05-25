//
//  Item.swift
//  Todoey
//
//  Created by NazarStf on 24.05.2023.
//

import Foundation
import RealmSwift

class Item: Object {
	@objc dynamic var title: String = ""
	@objc dynamic var done: Bool = false
}

class DataModel {
	
	private let realm = try! Realm()
	
	private var items: [Item] = []
	
	func getItems() -> Results<Item> {
		return realm.objects(Item.self)
	}

	func addItem(_ newItem: Item) {
		do {
			try realm.write {
				realm.add(newItem)
			}
		} catch {
			fatalError("Unable to save item: \(error)")
		}
	}

	func deleteItem(at index: Int) {
		let items = getItems()
		guard index < items.count else {
			fatalError("Invalid index")
		}
		
		let item = items[index]
		
		do {
			try realm.write {
				realm.delete(item)
			}
		} catch {
			fatalError("Unable to delete item: \(error)")
		}
	}
	
	func updateItem(at index: Int, withUpdatedItem updatedItem: Item) {
		let item = items[index]
		do {
			try realm.write {
				item.title = updatedItem.title
				item.done = updatedItem.done
			}
		} catch {
			fatalError("Unable to update item: \(error)")
		}
	}

}
