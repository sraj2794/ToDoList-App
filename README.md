# ToDoList-App
The TodoList App is a simple and intuitive task management application for iOS. The app allows you to add tasks with deadlines, mark tasks as done, and get notifications for overdue tasks.

# Features
Add Tasks: Create new tasks with a title and deadline.
Task List: View tasks in progress and completed tasks separately.
Mark Tasks as Done: Mark tasks as completed from the task list.
Overdue Notifications: Get notified when tasks are overdue.
Persistent Storage: Save tasks locally on your device.

# Screenshots
<img src="https://github.com/sraj2794/ToDoList-App/assets/41502704/bbb5491f-5504-4da2-9819-6cdef3e9ce77" width="300">
<img src="https://github.com/sraj2794/ToDoList-App/assets/41502704/69c21554-1202-44e9-9bd1-d7e9b78e7f0a" width="300">
<img src="https://github.com/sraj2794/ToDoList-App/assets/41502704/1aeb4e81-45c1-4abc-b861-fba13efb16c9" width="300">
<img src="https://github.com/sraj2794/ToDoList-App/assets/41502704/bd86624c-fdae-4514-a8a1-078bbf7c6d4f" width="300">

# Requirements
iOS 13.0+
Xcode 11.0+
Swift 5.0+

# Installation
Clone the repository:
bash
Copy code
git clone https://github.com/sraj2794/ToDoList-App.git
Open the project in Xcode:
bash
Copy code
cd todolist-ios
open TodoAPP.xcodeproj
Build and run the project on your simulator or device.

# Usage
Add a Task: Tap the "Add Task" button and enter the task title and deadline. Tap "Add" to save the task.
View Tasks: The main screen displays tasks in progress and completed tasks in separate sections.
Mark Task as Done: Swipe a task to mark it as done. The task will move to the completed section.
Overdue Notifications: If a task's deadline passes, you'll receive a notification prompting you to mark it as done.

# Code Structure
AddTaskViewController: Handles the UI and logic for adding new tasks.
TaskListViewController: Displays the list of tasks and manages task completion.
TaskViewModel: Contains the business logic for managing tasks.
TaskModel: Represents the data model for a task.
TaskTableViewCell: Custom table view cell for displaying task information.

# Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Commit your changes (git commit -m 'Add some feature').
Push to the branch (git push origin feature/your-feature).
Open a pull request.



Contact
For any questions or suggestions, feel free to open an issue or contact me at sraj2794@gmail.com
