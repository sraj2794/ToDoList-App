//
//  TaskModel.swift
//  TodoAPP
//
//  Created by Raj Shekhar on 06/06/24.
//

import Foundation

enum TaskStatus: String, Codable {
    case inProgress
    case completed
}

struct TaskModel: Codable, Equatable{
    let title: String
    let deadline: String
    var status: TaskStatus = .inProgress
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.title == rhs.title && lhs.deadline == rhs.deadline && lhs.status == rhs.status
    }
}

