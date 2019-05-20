//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

class ConcentrationGame {
  
  // MARK: - Properties
  
  weak var delegate: ConcentrationGameDelegate?
  
  private(set) var cards: [Card] = []
  
  private var involvedInAMismatch: [Int: Bool] = [:]
  
  private(set) var score: Int = 0 {
    didSet {
      delegate?.updateScore(newScore: score)
    }
  }
  
  /// Score update rules
  private let scoreUpdateOnMatch = +2
  private let scoreUpdateOnMismatchForCard = -1
  
  // MARK: - Public methods
  
  init(pairsCount: Int) {
    guard pairsCount > 0 else { return }
    
    for _ in 1...pairsCount {
      let newCard = Card()
      cards += [newCard, newCard]
    }
    
    cards = cards.shuffled()
    
    for i in 0 ..< cards.count {
      involvedInAMismatch[i] = false
    }
  }
  
  func pickCard(with index: Int) {
    guard cards[index].status == .faceDown else { return }
    
    cards[index].status = .faceUp
    
    let faceUpCards = getCardsIndices(for: .faceUp)
    
    if faceUpCards.count == 2 {
      if cards[faceUpCards.first!].id == cards[faceUpCards.last!].id {
        // Match!
        for i in faceUpCards {
          cards[i].status = .matched
        }
        score = score + scoreUpdateOnMatch
        delegate?.registerMatch(firstIndex: faceUpCards.first!, secondIndex: faceUpCards.last!)
      } else {
        // Mismatch!
        var numOfPrevPickedCards = 0
        for i in faceUpCards {
          if involvedInAMismatch[i]! {
            numOfPrevPickedCards = numOfPrevPickedCards + 1
          }
          involvedInAMismatch[i] = true
          cards[i].status = .faceDown
        }
        score = score + numOfPrevPickedCards * scoreUpdateOnMismatchForCard
        delegate?.registerMismatch(firstIndex: faceUpCards.first!, secondIndex: faceUpCards.last!)
      }
    }
  }
  
  // MARK: - Private methods
  
  private func getCardsIndices(for status: Card.Status) -> [Int] {
    var result: [Int] = []
    for i in 0..<cards.count {
      if cards[i].status == status {
        result.append(i)
      }
    }
    return result
  }
}
