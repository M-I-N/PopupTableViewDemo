//
//  PopupAlertViewController.swift
//  PopupTableViewDemo
//
//  Created by Nayem BJIT on 2/19/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class PopupAlertViewController: NYAlertViewController {

    typealias SelectionHandler = (Model) -> Void

    private let alertTitle: String
    private let models: [Model]
    private var onSelect: SelectionHandler?

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let alertTitleContainerHeight: CGFloat = 48
    private let contentViewHeight: CGFloat = 183
    private let numberOfVisibleCell = 3
    private let themeBackgroundColor = UIColor.black
    private let tintColor = UIColor.white

    // Property override to customize default implementation
    override var configuration: NYAlertViewControllerConfiguration {
        let configuration = super.configuration
        configuration.transitionStyle = .fade
        configuration.backgroundTapDismissalGestureEnabled = true
        configuration.swipeDismissalGestureEnabled = false
        configuration.contentViewInset = UIEdgeInsets(top: 0, left: 0, bottom: -18, right: 0)   // for aligning bottom with the top of action buttons
        configuration.alertViewBackgroundColor = themeBackgroundColor
        configuration.titleTextColor = tintColor
        configuration.alertViewCornerRadius = 20

        let buttonConfiguration = NYAlertActionConfiguration()
        buttonConfiguration.titleColor = tintColor
        configuration.buttonConfiguration = buttonConfiguration
        return configuration
    }

    init(title: String, dismissButtonTitle: String, models: [Model], onSelect: SelectionHandler?) {
        self.alertTitle = title
        self.models = models
        self.onSelect = onSelect

        let dismissAction = NYAlertAction(title: dismissButtonTitle, style: .default, handler: nil)

        super.init(options: nil, title: nil, message: nil, actions: [dismissAction])

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupContentView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerReusableCell(AlertTableViewCell.self)
        tableView.backgroundColor = themeBackgroundColor
        tableView.rowHeight = (contentViewHeight - alertTitleContainerHeight) / CGFloat(integerLiteral: numberOfVisibleCell)
        tableView.separatorColor = configuration.separatorColor
        tableView.separatorInset = .zero
        tableView.separatorStyle = configuration.showsSeparators ? .singleLine : .none
    }

    private func setupContentView() {
        // add content view
        let contentView = UIView(frame: .zero)

        // add title view to content view
        let labelContainer = UIView(frame: .zero)
        labelContainer.backgroundColor = configuration.alertViewBackgroundColor

        let label = UILabel(frame: .zero)
        label.text = alertTitle
        label.textColor = configuration.titleTextColor
        labelContainer.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor).isActive = true

        let separatorView = UIView(frame: .zero)
        separatorView.backgroundColor = configuration.separatorColor
        labelContainer.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        let separatorHeight = configuration.showsSeparators ? 1 / UIScreen.main.scale : 0
        separatorView.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true

        contentView.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        labelContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelContainer.heightAnchor.constraint(equalToConstant: alertTitleContainerHeight).isActive = true

        // add table view to content view
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: contentViewHeight).isActive = true
        alertViewContentView = contentView
    }

}

extension PopupAlertViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AlertTableViewCell.dequeue(fromTableView: tableView, atIndex: indexPath)
        let model = models[indexPath.row]
        cell.titleLabel.text = model.name
        cell.backgroundColor = .clear
        return cell
    }

}

extension PopupAlertViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let model = self.models[indexPath.row]
            self.onSelect?(model)
        }
    }
}
