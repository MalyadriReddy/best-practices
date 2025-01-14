//
//  SolutionsModels.swift
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

public struct Solutions {
  struct Request {
    let value: Int
  }
  
  struct Response {
    let result: String
  }
  
  struct ViewModel {
    let result: String
  }
  
}
  


public enum Flow {
  case fizzBuzz
  case leapYear
  case leftTriangle
  case rightTriangle
  case invertV
  case xPattern
  case diamondPattern
  case lettersPattern
  case differenceBtwElseAndFinally
  case primeNumbers
}
