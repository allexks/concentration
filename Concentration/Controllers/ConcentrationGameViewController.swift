//
//  ConcentrationGameViewController.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

class ConcentrationGameViewController: UIViewController, ConcentrationGameDelegate {

  // MARK: - Properties
  var game: ConcentrationGame! {
    didSet {
      game.delegate = self
    }
  }
  
  var performWithDelay: ((Int, Int) -> Void)?
  var delayedArgs: (first: Int, second: Int)!
  
  
  // MARK: - Outlets
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var cardButtons: [UIButton]!
  
  
  // MARK: - Actions
  
  @IBAction func onTapCard(_ sender: UIButton) {
    guard let indexOfPickedCard = cardButtons.firstIndex(of: sender) else { return }
    if let delayedFunction = performWithDelay {
      delayedFunction(delayedArgs.first, delayedArgs.second)
    }
    flipFaceUp(indexOfPickedCard)
    game.pickCard(with: indexOfPickedCard)
  }
  
  
  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    loadNewGame()
    
  }
  
  
  // MARK: - Concentration Game Delegate
  func updateScore(newScore: Int) {
    scoreLabel.text = "Score: \(newScore)"
  }
  
  func registerMatch(firstIndex: Int, secondIndex: Int) {
    guard performWithDelay != nil else {
      performWithDelay = registerMatch(firstIndex:secondIndex:)
      delayedArgs = (firstIndex, secondIndex)
      return
    }
    performWithDelay = nil
    
    removeCard(firstIndex)
    removeCard(secondIndex)
  }
  
  func registerMismatch(firstIndex: Int, secondIndex: Int) {
    guard performWithDelay != nil else {
      performWithDelay = registerMismatch(firstIndex:secondIndex:)
      delayedArgs = (firstIndex, secondIndex)
      return
    }
    performWithDelay = nil
    
    flipFaceDown(firstIndex)
    flipFaceDown(secondIndex)
  }
  
  
  // MARK: - Private methods
  private func loadNewGame() {
    var pairs = cardButtons.count / 2
    if cardButtons.count % 2 == 1 {
      pairs = pairs + 1
    }
    
    game = ConcentrationGame(pairsCount: pairs)
    
    for i in 0..<cardButtons.count {
      flipFaceDown(i)
      cardButtons[i].alpha = 1
    }
  }
  
  private func flipFaceUp(_ index: Int) {

    cardButtons[index].backgroundColor = .white
    cardButtons[index].setTitle("X", for: .normal)
  }
  
  private func flipFaceDown(_ index: Int) {

    cardButtons[index].backgroundColor = .orange
    cardButtons[index].setTitle("", for: .normal)
  }
  
  private func removeCard(_ index: Int) {
    cardButtons[index].alpha = 0
  }
}
