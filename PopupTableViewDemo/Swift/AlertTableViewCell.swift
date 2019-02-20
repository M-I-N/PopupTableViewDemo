//
//  AlertTableViewCell.swift
//  PopupTableViewDemo
//
//  Created by Nayem BJIT on 2/19/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    internal static func dequeue(fromTableView tableView: UITableView, atIndex index: IndexPath) -> AlertTableViewCell {
        guard let cell: AlertTableViewCell = tableView.dequeueReusableCell(indexPath: index) else {
            fatalError("*** Failed to dequeue CollectionViewCell ***")
        }
        return cell
    }
    
}
