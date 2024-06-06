//
//  AddTaskViewController.swift
//  TodoAPP
//
//  Created by Raj Shekhar on 06/06/24.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func didAddTask(_ task: TaskModel)
}

enum NotesValidation: String {
    case title = "Please enter title"
    case date = "Please select date"
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var lblTopTitle: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnAdd: UIButton!

    var datePicker = UIDatePicker()
    weak var delegate: AddTaskViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        setupDatePicker()
        setupTapGesture()
    }

    private func setupDatePicker() {
        // DatePickerView
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.backgroundColor = .lightGray
        datePicker.datePickerMode = .dateAndTime 
        datePicker.maximumDate = nil
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.barTintColor = UIColor(named: "colour-4")
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        doneButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = .white
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
    }
    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        txtDate.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDateTapped))
        viewDate.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDateTapped() {
        txtDate.becomeFirstResponder()
    }
    
    @objc func cancelDatePicker() {
        view.endEditing(true)
    }
    
    @IBAction func onClickCancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAddBtn(_ sender: Any) {
        let validation = doValidation()
        if validation.0 {
            guard let title = txtTitle.text, !title.isEmpty else { return }
            guard let deadline = txtDate.text, !deadline.isEmpty else { return }
            let task = TaskModel(title: title, deadline: deadline)
            delegate?.didAddTask(task)
            showAlert(title: "Success", message: "Add note successfully") { _ in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert(title: "Error", message: validation.1, hendler: nil)
        }
    }
}

// Extension
extension AddTaskViewController {
    func initialSetUp() {
        viewTitle.clipsToBounds = true
        viewTitle.layer.cornerRadius = 20
        viewTitle.layer.shadowColor = UIColor(named: "colour-5")?.cgColor
        viewTitle.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        viewTitle.layer.shadowRadius = 2.0
        viewTitle.layer.shadowOpacity = 1.0
        viewTitle.layer.masksToBounds = false

        viewDate.clipsToBounds = true
        viewDate.layer.cornerRadius = 20
        viewDate.layer.shadowColor = UIColor(named: "colour-5")?.cgColor
        viewDate.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        viewDate.layer.shadowRadius = 2.0
        viewDate.layer.shadowOpacity = 1.0
        viewDate.layer.masksToBounds = false
        
        btnAdd.clipsToBounds = true
        btnAdd.layer.cornerRadius = 25
        btnAdd.layer.shadowColor = UIColor.black.cgColor
        btnAdd.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        btnAdd.layer.shadowRadius = 2.0
        btnAdd.layer.shadowOpacity = 1.0
        btnAdd.layer.masksToBounds = false
    }
    
    func doValidation() -> (Bool, String) {
        if txtTitle.text?.isEmpty ?? false {
            return (false, NotesValidation.title.rawValue)
        } else if txtDate.text?.isEmpty ?? false {
            return (false, NotesValidation.date.rawValue)
        }
        return (true, "")
    }
}
