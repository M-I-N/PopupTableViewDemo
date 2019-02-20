//
//  Model.swift
//  PopupTableViewDemo
//
//  Created by Nayem BJIT on 2/20/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import Foundation

class Model {
    let name: String
    let ID: Int

    init(name: String, ID: Int) {
        self.name = name
        self.ID = ID
    }

    static func allModels() -> [Model] {
        return [Model(name: "Option 1", ID: 1), Model(name: "Option 2", ID: 2), Model(name: "Option 3", ID: 3), Model(name: "Option 4", ID: 4), Model(name: "Option 5", ID: 5)]
    }
}
