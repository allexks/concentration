//
//  Card.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

struct Card {
  typealias IDType = UInt64
  private static var lastId: IDType = 0
  private static func generateNextId() -> IDType {
    lastId = lastId + 1
    return lastId
  }
  
  let id: IDType!
  var status: Status = .faceDown
  
  init() {
    id = Card.generateNextId()
  }
}

extension Card {
  enum Status {
    case faceDown
    case faceUp
    case matched
  }
}
