//
//  Model.swift
//  CODIUM
//
//  Created by Malyadri on 13/12/19.
//  Copyright © 2019 codium. All rights reserved.
//

import Foundation

public struct ToDoList {
  public let todoList = ["Task List", "1.FizzBuzz", "2.Leap Year", "3.1", "3.2", "3.3", "3.4", "3.5", "3.6", "4. Difference b/w else and finally", "Prime numbers program"]
}
public struct UserTaskList {
  //var id: Int { get }
  var taskDescription: [String]

  public init(taskDescription: [String]) {
    self.taskDescription = taskDescription
  }
  
}
