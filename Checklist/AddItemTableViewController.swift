//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by John Martin on 9/22/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
}

protocol ChecklistItemDelegate: class {
     var itemToEdit: ChecklistItem? { get }
}

class AddItemTableViewController: UITableViewController, ChecklistItemDelegate {

    weak var delegate: AddItemTableViewControllerDelegate?

    weak var todoList: TodoList?

    weak var itemToEdit: ChecklistItem?

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!

    @IBOutlet weak var textfield: UITextField!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done(_ sender: Any) {
        let text: String = textfield.text ?? ""

        if let item = itemToEdit {
            item.text = text
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem(text: text, isChecked: false)
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         doneBarButton.isEnabled = false

        if let item = itemToEdit {
            title = "Edit Item"
            textfield.text = item.text
            textfield.placeholder = "Enter to edit todo"
            doneBarButton.isEnabled = true
        }

        navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.textfield.becomeFirstResponder()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        DispatchQueue.main.async {
            self.textfield.resignFirstResponder()
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}
extension AddItemTableViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.textfield.resignFirstResponder()
        }
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textfield.text, let stringRange = Range(range, in: oldText) else { return false }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
