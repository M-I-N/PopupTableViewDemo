//
//  HomeViewController.swift
//  PopupTableViewDemo
//
//  Created by Nayem BJIT on 2/19/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func popupButtonDidTap(_ sender: UIButton) {
        let models = Model.allModels()
        let popupAlertController = PopupAlertViewController(title: "Choose an Option", dismissButtonTitle: "Cancel", models: models) { [weak self] selectedModel in
            self?.performSegue(withIdentifier: "DetailSegue", sender: selectedModel)
        }
        popupAlertController.maximumWidth = 270
        present(popupAlertController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue", let detailViewController = segue.destination as? DetailViewController {
            if let selectedModel = sender as? Model {
                detailViewController.model = selectedModel
            }
        }
    }

}

