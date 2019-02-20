//
//  DetailViewController.swift
//  PopupTableViewDemo
//
//  Created by Nayem BJIT on 2/20/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var model: Model? {
        didSet {
            guard let model = model else { return }
            DispatchQueue.main.async {
                self.textLabel.text = "\(model.name)'s Detail Page"
            }
        }
    }

    @IBOutlet private weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
