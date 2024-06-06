//
//  TaskListViewController.swift
//  TodoAPP
//
//  Created by Raj Shekhar on 06/06/24.
//

import UIKit

import UIKit

class TaskListViewController: UIViewController, AddTaskViewControllerDelegate {
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var btnAddTask: UIButton!
    @IBOutlet weak var lblNotesNotFound: UILabel!

    let viewModel = TaskViewModel()
    private var overdueTasksQueue: [TaskModel] = []
    private var overdueCheckTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        taskTableView.delegate = self
        taskTableView.dataSource = self
        lblNotesNotFound.isHidden = true
        tasksNotFound()
        registerXib()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksNotFound()
        startOverdueCheckTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopOverdueCheckTimer()
    }

    @IBAction func btnAddTaskAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addTaskVC = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController {
            addTaskVC.delegate = self
            navigationController?.pushViewController(addTaskVC, animated: true)
        }
    }

    func didAddTask(_ task: TaskModel) {
        viewModel.addTask(title: task.title, deadline: task.deadline)
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }

    func registerXib() {
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        taskTableView.register(nib, forCellReuseIdentifier: "TaskTableViewCell")
    }

    func tasksNotFound() {
        lblNotesNotFound.isHidden = !viewModel.tasks.isEmpty
    }

    func startOverdueCheckTimer() {
        overdueCheckTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(checkForOverdueTasks), userInfo: nil, repeats: true)
    }

    func stopOverdueCheckTimer() {
        overdueCheckTimer?.invalidate()
        overdueCheckTimer = nil
    }

    @objc func checkForOverdueTasks() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy 'at' h:mm a"
        overdueTasksQueue.removeAll()
        for task in viewModel.inProgressTasks() {
            if let deadlineDate = dateFormatter.date(from: task.deadline), deadlineDate < now {
                overdueTasksQueue.append(task)
            }
        }
        showNextOverduePopup()
    }

    func showNextOverduePopup() {
        if overdueTasksQueue.isEmpty {
            return
        }
        
        let task = overdueTasksQueue.removeFirst()
        guard let taskIndex = viewModel.tasks.firstIndex(of: task) else {
            showNextOverduePopup()
            return
        }

        let alert = UIAlertController(title: "Task Overdue", message: "The task \"\(task.title)\" is overdue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.showNextOverduePopup()
        }))
        alert.addAction(UIAlertAction(title: "Mark Done", style: .default, handler: { _ in
            self.viewModel.markTaskAsDone(at: taskIndex)
            self.taskTableView.reloadData()
            self.showNextOverduePopup()
        }))
        present(alert, animated: true, completion: nil)
    }

    func showTaskOptionsPopup(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "Task Options", message: "What would you like to do with the task?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Mark Done", style: .default, handler: { _ in
            let taskIndex = self.taskIndex(for: indexPath)
            self.viewModel.markTaskAsDone(at: taskIndex)
            self.taskTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func taskIndex(for indexPath: IndexPath) -> Int {
        if indexPath.section == 0 {
            return viewModel.tasks.firstIndex { $0.status == .inProgress && $0 == viewModel.inProgressTasks()[indexPath.row] }!
        } else {
            return viewModel.tasks.firstIndex { $0.status == .completed && $0 == viewModel.completedTasks()[indexPath.row] }!
        }
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.inProgressTasks().count : viewModel.completedTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell {
            let task = indexPath.section == 0 ? viewModel.inProgressTasks()[indexPath.row] : viewModel.completedTasks()[indexPath.row]
            cell.configureCell(task)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "In Progress" : "Completed"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskOptionsPopup(for: indexPath)
    }
}
