//
//  TodoListViewController.swift
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

protocol TodoListViewControllerInterface: class {
  func displayTodoList(viewModel: Todo.GetTodoList.ViewModel)
}

class TodoListViewController: UIViewController, TodoListViewControllerInterface {
  
  var interactor: TodoListInteractorInterface!
  var router: TodoListRouterInterface!
  var todoList: [String] = []
  
  // UI Outlets
  @IBOutlet weak var todoListTableView: UITableView!
  
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: TodoListViewController) {
    let router = TodoListRouter()
    router.viewController = viewController
    
    let presenter = TodoListPresenter()
    presenter.viewController = viewController
    
    let interactor = TodoListInteractor()
    interactor.presenter = presenter
    
    viewController.interactor = interactor
    viewController.router = router
  }


  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewSetUp()
    getTodoList()
  }
  
  private func tableViewSetUp() {
    todoListTableView.rowHeight = UITableView.automaticDimension
    todoListTableView.estimatedRowHeight = 40
    todoListTableView.tableFooterView = UIView()
  }
  
  private func getTodoList() {
    let request = Todo.GetTodoList.Request()
    interactor.getTodoList(request: request)
  }
 
  func displayTodoList(viewModel: Todo.GetTodoList.ViewModel) {
    todoList = viewModel.todoList
    todoListTableView.reloadData()
  }

}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // create a new cell if needed or reuse an old one
    let cell:UITableViewCell = todoListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    // set the text from the data model
    cell.textLabel?.text = todoList[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    router.navigateToDetails(indexPath: indexPath)
  }
  
}
