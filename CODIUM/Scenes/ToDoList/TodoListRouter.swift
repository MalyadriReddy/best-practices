//
//  TodoListRouter.swift
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

protocol TodoListRouterInterface {
  func navigateToDetails(indexPath: IndexPath)
}

class TodoListRouter: TodoListRouterInterface {
  weak var viewController: TodoListViewController!
  
  func navigateToDetails(indexPath: IndexPath) {
    
    if indexPath.row == 0 {
      let storyboard = UIStoryboard(name: "UserTaskList", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UserTaskViewController") as! UserTaskViewController
          viewController.navigationController?.pushViewController(destinationVC, animated: true)
    } else if indexPath.row == 1 {
      navigateToSolutions(flow: .fizzBuzz)
    } else if indexPath.row == 2 {
      navigateToSolutions(flow: .leapYear)
    } else if indexPath.row == 3 {
      navigateToSolutions(flow: .leftTriangle)
    } else if indexPath.row == 4 {
      navigateToSolutions(flow: .rightTriangle)
    } else if indexPath.row == 5 {
      navigateToSolutions(flow: .invertV)
    } else if indexPath.row == 6 {
      navigateToSolutions(flow: .xPattern)
    } else if indexPath.row == 7 {
      navigateToSolutions(flow: .diamondPattern)
    } else if indexPath.row == 8 {
      navigateToSolutions(flow: .lettersPattern)
    } else if indexPath.row == 9 {
      navigateToSolutions(flow: .differenceBtwElseAndFinally)
    } else if indexPath.row == 10 {
      navigateToSolutions(flow: .primeNumbers)
    }
    
  }
  
  private func navigateToSolutions(flow: Flow) {
    let storyboard = UIStoryboard(name: "Solutions", bundle: nil)
    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SolutionsViewController") as! SolutionsViewController
    destinationVC.interactor.flow = flow
    viewController.navigationController?.pushViewController(destinationVC, animated: true)
  }
 
}
