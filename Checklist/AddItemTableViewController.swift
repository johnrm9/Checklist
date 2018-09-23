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
}

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemTableViewControllerDelegate?

    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!

    @IBOutlet weak var textfield: UITextField!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let text: String = textfield.text ?? ""
        let item = ChecklistItem(text: text, isChecked: false)
        delegate?.addItemViewController(self, didFinishAdding: item)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        addBarButton.isEnabled = false
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
        addBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
