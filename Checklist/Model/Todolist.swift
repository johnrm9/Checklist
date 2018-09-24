//
//  Todolist.swift
//  Checklist
//
//  Created by John Martin on 9/20/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

class TodoList {

    private var todos: [ChecklistItem] = []

    init() {
        todos = [
            ChecklistItem(text: "Take a jog"),
            ChecklistItem(text: "Watch a movie"),
            ChecklistItem(text: "Code an app"),
            ChecklistItem(text: "Walk the dog"),
            ChecklistItem(text: "Study design patterns")
        ]
    }
    @discardableResult
    func addItem(_ item: ChecklistItem) -> ChecklistItem {
        todos.append(item)
        return item
    }

    func remove(at index: Int) {
        todos.remove(at: index)
    }

    @discardableResult
    func newTodo() -> ChecklistItem {
        let text = randomTitle()
        let item = ChecklistItem(text: text)
        return addItem(item)
    }

    func index(of item: ChecklistItem) -> Int? {
        return todos.index(of: item)
    }

    subscript(row: Int) -> ChecklistItem {
        get {
            return todos[row]
        }
        set {
            todos[row] = newValue
        }
    }

    var count: Int {
        return todos.count
    }
    private func randomTitle() -> String {
        let titles = ["New todo item", "Generic item", "Fill me out", "I need something to do",
                      "Much todo about nothing"]
        let range = 0..<titles.count
        let index = Int.random(in: range)
        return titles[index]
    }

}
