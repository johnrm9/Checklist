//
//  ChecklistItem.swift
//  Checklist
//
//  Created by John Martin on 9/20/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

struct ChecklistItem {
    let text: String
    var isChecked: Bool = false

    mutating func toggled() -> ChecklistItem {
        isChecked.toggle()
        return self
    }

    init(text: String, isChecked: Bool = false) {
        self.text = text
        self.isChecked = isChecked
    }
}
