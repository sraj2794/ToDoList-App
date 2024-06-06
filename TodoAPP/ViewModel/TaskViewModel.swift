//
//  TaskViewModel.swift
//  TodoAPP
//
//  Created by Raj Shekhar on 06/06/24.
//

import Foundation

class TaskViewModel {
    private let userDefaultsKey = "tasks"
    private (set) var tasks: [TaskModel] = []

    init() {
        loadTasks()
    }

    func addTask(title: String, deadline: String) {
        let newTask = TaskModel(title: title, deadline: deadline)
        tasks.append(newTask)
        saveTasks()
    }

    func markTaskAsDone(at index: Int) {
        tasks[index].status = .completed
        saveTasks()
    }

    func inProgressTasks() -> [TaskModel] {
        return tasks.filter { $0.status == .inProgress }
    }

    func completedTasks() -> [TaskModel] {
        return tasks.filter { $0.status == .completed }
    }

    func moveTaskToCompleted(at index: Int) {
        tasks[index].status = .completed
        saveTasks()
    }

    private func saveTasks() {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: userDefaultsKey)
        }
    }

    private func loadTasks() {
        if let savedTasksData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedTasks = try? JSONDecoder().decode([TaskModel].self, from: savedTasksData) {
            tasks = savedTasks
        }
    }
}
