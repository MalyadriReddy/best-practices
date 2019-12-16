//
//  TaskStore.swift
//  CODIUM
//
//  Created by Malyadri on 14/12/19.
//  Copyright © 2019 codium. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class TaskStore: UserTaskProtocol {
  
  
  func fetchTaskListfromDatabase(completion: @escaping (Result<UserTaskList, DataError>) -> Void) {
    // Refer Container From AppDeligates which is mentioned default
    guard let appDeligate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    // Create Context from this container
    let managedContext = appDeligate.persistentContainer.viewContext
    
    // Prepare Request of Type NSFetchRequest
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskList")
    do {
      let result = try managedContext.fetch(fetchRequest)
      var taskData: [String] = []
      for data in result as! [NSManagedObject] {
        taskData.append(data.value(forKey: "taskDescription") as! String)
      }
      let task = UserTaskList(taskDescription: taskData)
      completion(.success(task))
    } catch let error as NSError {
      return completion(.failure(.databaseFailure(error)))
    }
  }
  
  func storeTask(taskDescription taskData: String, completion: @escaping (Result<UserTaskList, DataError>) -> Void) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let taskEntity = NSEntityDescription.entity(forEntityName: "TaskList", in: managedContext)!
    
    let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
    task.setValue(taskData, forKey: "taskDescription")
    let tasklist = UserTaskList(taskDescription: [])
    
    do {
      try managedContext.save()
      completion(.success(tasklist))
    } catch let error as NSError {
      return completion(.failure(.databaseFailure(error)))
    }
  }
  
  func deleteTask(taskDescription taskData: String, completion: @escaping (Result<UserTaskList, DataError>) -> Void) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskList")
    fetchRequest.predicate = NSPredicate(format: "taskDescription = %@", taskData)
    
    let tasklist = UserTaskList(taskDescription: [])
    
    do {
      let data = try managedContext.fetch(fetchRequest)
      let objectToDelete = data[0] as! NSManagedObject
      managedContext.delete(objectToDelete)
      do {
        try managedContext.save()
        completion(.success(tasklist))

      } catch let error as NSError {
        return completion(.failure(.databaseFailure(error)))
      }
      
    } catch let error as NSError {
      return completion(.failure(.databaseFailure(error)))
    }
  }
}
