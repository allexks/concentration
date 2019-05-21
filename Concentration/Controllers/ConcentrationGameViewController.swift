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
  
  var theme = Themes.shared.themes["faces"]!
  var emojisMapper: [Card.IDType: String] = [:]
  
  let delayInSeconds: TimeInterval = 0.5
  
  
  // MARK: - Outlets
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var cardButtons: [UIButton]!
  @IBOutlet weak var navItem: UINavigationItem!
  
  
  // MARK: - Actions
  @IBAction func onTapCard(_ sender: UIButton) {
    guard let indexOfPickedCard = cardButtons.firstIndex(of: sender) else { return }
    flipFaceUp(indexOfPickedCard)
    game.pickCard(with: indexOfPickedCard)
  }
  
  @IBAction func onTapNewGameButton(_ sender: UIBarButtonItem) {
    loadNewGame()
  }
  @IBAction func onTapNewThemeButton(_ sender: Any) {
    loadNewTheme(nil)
    reloadViews()
  }
  
  
  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    loadNewGame(newTheme: true, themeName: nil)
  }
  
  
  // MARK: - Concentration Game Delegate
  func updateScore(newScore: Int) {
    scoreLabel.text = "Score: \(newScore)"
  }
  
  func registerMatch(firstIndex: Int, secondIndex: Int) {
    perform(#selector(onMatch(_:)), with: [firstIndex, secondIndex], afterDelay: delayInSeconds)
  }
  
  func registerMismatch(firstIndex: Int, secondIndex: Int) {
    perform(#selector(onMismatch(_:)), with: [firstIndex, secondIndex], afterDelay: delayInSeconds)
  }
  
  // MARK: - Helper methods
  @objc func onMatch(_ indices: [Int]) {
    removeCard(indices[0])
    removeCard(indices[1])
  }
  
  @objc func onMismatch(_ indices: [Int]) {
    flipFaceDown(indices[0])
    flipFaceDown(indices[1])
  }
  
  private func loadNewGame(newTheme: Bool = false, themeName: String? = nil) {
    game = ConcentrationGame(pairsCount: numberOfPairs)
    
    if newTheme {
      loadNewTheme(themeName)
    }
    reloadViews()
  }
  
  private func loadNewTheme(_ name: String?) {
    /// name is nil for a random theme
    if let name = name, let newTheme = Themes.shared.themes[name] {
      theme = newTheme
    } else {
      theme = Themes.shared.selectRandomTheme()
    }
    
    
  }
  
  private func reloadViews() {
    emojisMapper = [:]
    
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
    navItem.title = theme.title
    
    for i in 0..<cardButtons.count {
      switch game.cards[i].status {
      case .faceDown:
        flipFaceDown(i)
      case .faceUp:
        flipFaceUp(i)
      case .matched:
        removeCard(i)
      }
      
    }
  }
  
  private func flipFaceUp(_ index: Int) {

    cardButtons[index].backgroundColor = theme.cardForegroundColor
    let attrString = NSAttributedString(string: emojisMapper[game.cards[index].id]!, attributes: [.font : font] )
    cardButtons[index].setAttributedTitle(attrString, for: .normal)
    cardButtons[index].alpha = 1
  }
  
  private func flipFaceDown(_ index: Int) {

    cardButtons[index].backgroundColor = theme.cardBackgroundColor
    cardButtons[index].setAttributedTitle(NSAttributedString(string: "", attributes: nil), for: .normal)
    cardButtons[index].alpha = 1
  }
  
  private func removeCard(_ index: Int) {
    cardButtons[index].alpha = 0
  }
}
