//
//  UserTaskViewController.swift
//  CODIUM
//
//  Created by Malyadri on 13/12/19.
//  Copyright (c) 2019 codium. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserTaskViewControllerInterface: class {
  func displayUserTaskList(viewModel: UserTask.GetUserTaskList.ViewModel)
  func displaySaveTask(viewModel: UserTask.SaveTask.ViewModel)
  func displayDeleteTask(viewModel: UserTask.DeleteTask.ViewModel)
}

class UserTaskViewController: UIViewController, UserTaskViewControllerInterface {
  
  var interactor: UserTaskInteractorInterface!
  var router: UserTaskRouterInterface!

  //UI outlets
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var taskListTableView: UITableView!
  @IBOutlet weak var taskInputViewHightConstraint: NSLayoutConstraint!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var taskInputView: UIView!
  @IBOutlet weak var listBackGroundView: UIView!
  @IBOutlet weak var cancelButton: UIButton!
  
  
  var userTaskList: [String] = []
  
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: UserTaskViewController) {
    let router = UserTaskRouter()
    router.viewController = viewController
    
    let presenter = UserTaskPresenter()
    presenter.viewController = viewController
    
    let interactor = UserTaskInteractor()
    interactor.presenter = presenter
    interactor.worker = UserTaskWorker(store: TaskStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetUp()
    getUserTaskList()
  }
  
  private func initialSetUp() {
    taskInputView.layer.cornerRadius = 10
    
    saveButton.layer.cornerRadius = 10
    saveButton.backgroundColor = .lightGray
    saveButton.isEnabled = false
    
    listBackGroundView.layer.cornerRadius = 10
    taskListTableView.layer.cornerRadius = 10
    taskListTableView.tableFooterView = UIView()
    taskListTableView.separatorInset = .zero

    cancelButton.layer.cornerRadius = 10
    
    setTaskInputView(0.0)

  }
  
  private func setTaskInputView(_ hight: CGFloat) {
     taskInputViewHightConstraint.constant = hight
  }
  
  
  private func getUserTaskList() {
    let request = UserTask.GetUserTaskList.Request()
    interactor.getUserTaskList(request: request)
  }
  
  private func deleteUserTask(task: String) {
    interactor.deleteUserTask(request: UserTask.DeleteTask.Request(task: task))
  }
  
  func displayUserTaskList(viewModel: UserTask.GetUserTaskList.ViewModel) {
    if !viewModel.taskList.isEmpty {
      listBackGroundView.isHidden = false
      userTaskList = viewModel.taskList
      taskListTableView.reloadData()
    } else {
      listBackGroundView.isHidden = true
      let alert = UIAlertController(title: "Alert", message: "Data not available.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  func displaySaveTask(viewModel: UserTask.SaveTask.ViewModel) {
    if viewModel.success {
      taskTextField.text = ""
      saveButton.backgroundColor = .lightGray
      saveButton.isEnabled = false
      setTaskInputView(0.0)
      getUserTaskList()
    } else {
      let alert = UIAlertController(title: "Alert", message: "Data save failed.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  func displayDeleteTask(viewModel: UserTask.DeleteTask.ViewModel) {
    if viewModel.success {
      getUserTaskList()
    } else {
      let alert = UIAlertController(title: "Alert", message: "Data delete failed.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func cancelOnclick(_ sender: Any) {
    taskTextField.resignFirstResponder()
    taskTextField.text = ""
    setTaskInputView(0.0)
  }
  @IBAction func addTaskOnClick(_ sender: Any) {
    setTaskInputView(120.0)
  }
  @IBAction func saveTaskOnClick(_ sender: Any) {
    taskTextField.resignFirstResponder()
    saveTask(task: taskTextField.text ?? "")
  }
  
  private func saveTask(task: String) {
    let request = UserTask.SaveTask.Request(task: task)
    interactor.saveUserTask(request: request)
  }
 
}
extension UserTaskViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard range.location == 0 else {
      saveButton.isEnabled = true
      saveButton.backgroundColor = .black
      return true
    }
    
    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
    saveButton.isEnabled = false
    saveButton.backgroundColor = .lightGray
    return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
  }
}
extension UserTaskViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userTaskList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = taskListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = userTaskList[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let alert = UIAlertController(title: "Alert", message: userTaskList[indexPath.row], preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
      deleteUserTask(task: userTaskList[indexPath.row])
    }
  }
}
