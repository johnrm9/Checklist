//
//  ChecklistItem.swift
//  Checklist
//
//  Created by John Martin on 9/20/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    private var _text: String
    private var _isChecked: Bool = false

    func toggled() -> ChecklistItem {
        _isChecked.toggle()
        return self
    }

    var text: String {
        get {
            return _text
        }
        set {
            _text = newValue
        }
    }
    var isChecked: Bool {
        return _isChecked
    }

    init(text: String, isChecked: Bool = false) {
        self._text = text
        self._isChecked = isChecked
    }
}
