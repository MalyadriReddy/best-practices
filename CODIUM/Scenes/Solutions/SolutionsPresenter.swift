//
//  SolutionsPresenter.swift
//  CODIUM
//
//  Created by Malyadri on 15/12/19.
//  Copyright (c) 2019 codium. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SolutionsPresenterInterface {
  func presentSolutionsResponse(response: Solutions.Response)
}

class SolutionsPresenter: SolutionsPresenterInterface {
  weak var viewController: SolutionsViewControllerInterface?
  
  func presentSolutionsResponse(response: Solutions.Response) {
    viewController?.displaySolutionResult(viewModel: Solutions.ViewModel(result: response.result))

  }

}
