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
  
  var numberOfPairs: Int {
    var pairs = cardButtons.count / 2
    if cardButtons.count % 2 == 1 {
      pairs = pairs + 1
    }
    return pairs
  }
  
  let emojiFontSizeMultiplier = CGFloat(50.0)
  var font : UIFont {
    return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(emojiFontSizeMultiplier))
  }
  
  let theme = Themes.shared.faces
  var emojisMapper: [Card.IDType: String] = [:]
  
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
    
    let emojis = theme.getRandomEmojis(emojisCount: numberOfPairs).map { String($0) }
    var nextIndex = 0
    for card in game.cards {
      if emojisMapper[card.id] == nil {
        emojisMapper[card.id] = emojis[nextIndex]
        nextIndex = nextIndex + 1
      }
    }
    
    view.backgroundColor = theme.appBackgroundColor
    scoreLabel.textColor = theme.scoreLabelTextColor
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
    game = ConcentrationGame(pairsCount: numberOfPairs)
    
    for i in 0..<cardButtons.count {
      flipFaceDown(i)
      cardButtons[i].alpha = 1
    }
  }
  
  private func flipFaceUp(_ index: Int) {

    cardButtons[index].backgroundColor = theme.cardForegroundColor
    let attrString = NSAttributedString(string: emojisMapper[game.cards[index].id]!, attributes: [.font : font] )
    cardButtons[index].setAttributedTitle(attrString, for: .normal)
  }
  
  private func flipFaceDown(_ index: Int) {

    cardButtons[index].backgroundColor = theme.cardBackgroundColor
    cardButtons[index].setAttributedTitle(NSAttributedString(string: "", attributes: nil), for: .normal)
  }
  
  private func removeCard(_ index: Int) {
    cardButtons[index].alpha = 0
  }
}
