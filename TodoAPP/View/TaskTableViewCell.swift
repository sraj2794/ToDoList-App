//
//  TaskTableViewCell.swift
//  TodoAPP
//
//  Created by Raj Shekhar on 06/06/24.
//

import UIKit

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskReminderLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ model: TaskModel) {
        self.taskNameLabel.text = model.title
        self.taskReminderLabel.text = model.deadline
        if model.status == .completed {
            self.taskNameLabel.textColor = .black
            self.taskReminderLabel.textColor = .black
            self.containerView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        } else {
            self.taskNameLabel.textColor = .black
            self.taskReminderLabel.textColor = .black
            self.containerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
    }

    private func setupUI() {
        // Configure the containerView
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.backgroundColor = UIColor.white
    }
}
