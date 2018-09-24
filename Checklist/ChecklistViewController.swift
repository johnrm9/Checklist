//
//  ChecklistViewController.swift
//  Checklist
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    let cellId: String = "CheckListItem"
    let labelTag: Int = 1000
    let labelCheckmarkTag: Int = 1001

    let todoList = TodoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let item = todoList[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        let item = todoList[indexPath.row].toggled()
        configureCheckmark(for: cell, with: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic  )
    }

    private func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let label = cell.viewWithTag(labelTag) as? UILabel else { return }
        label.text = item.text
    }

    private func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmarkLabel = cell.viewWithTag(labelCheckmarkTag) as? UILabel else { return }
        checkmarkLabel.text = item.isChecked ? "✓" : ""
    }

    enum SegueIdentifer: String {
        case AddItemSegue
        case EditItemSegue
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueIdentifer = SegueIdentifer(rawValue: identifier),
            let addItemViewController = segue.destination as? AddItemTableViewController else { return }

        addItemViewController.delegate = self

        switch segueIdentifer {
        case .AddItemSegue:
            addItemViewController.todoList = todoList
        case .EditItemSegue:
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let item = todoList[indexPath.row]
                addItemViewController.itemToEdit = item
            }
        }
    }
}

extension ChecklistViewController: AddItemTableViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }

    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let row = todoList.count
        todoList.addItem(item)
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }

    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        guard let row = todoList.index(of: item),
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) else { return }
            configureText(for: cell, with: item)
    }
}

