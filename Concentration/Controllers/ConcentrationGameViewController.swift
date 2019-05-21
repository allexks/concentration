//
//  ConcentrationGameViewController.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

class ConcentrationGameViewController: UIViewController, ConcentrationGameDelegate {
  
  // MARK: - Outlets
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var cardButtons: [UIButton]!
  @IBOutlet weak var navItem: UINavigationItem!
  
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
  
  let cardFlipDelayInSeconds: TimeInterval = 0.5
  let cardFlipDurationInSeconds: TimeInterval = 0.3
  
  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadNewGame(newTheme: true, themeName: nil)
  }
  
  // MARK: - Actions
  @IBAction func onTapCard(_ sender: UIButton) {
    guard let indexOfPickedCard = cardButtons.firstIndex(of: sender), game.cards[indexOfPickedCard].status == .faceDown else { return }
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
  
  // MARK: - Concentration Game Delegate
  func updateScore(newScore: Int) {
    scoreLabel.text = "Score: \(newScore)"
  }
  
  func registerMatch(firstIndex: Int, secondIndex: Int) {
    removeCard(firstIndex)
    removeCard(secondIndex)
  }
  
  func registerMismatch(firstIndex: Int, secondIndex: Int) {
    DispatchQueue.main.asyncAfter(deadline: .now() + cardFlipDelayInSeconds) {
      [weak self] in
      guard let self = self else { return }
      self.flipFaceDown(firstIndex)
      self.flipFaceDown(secondIndex)
    }
  }
  
  // MARK: - Helper methods
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
    updateScore(newScore: game.score)
    
    
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
    UIView.transition(with: cardButtons[index],
                   duration: cardFlipDurationInSeconds,
                   options: .transitionFlipFromLeft,
                   animations: { [weak self] in
                    guard let self = self else { return }
                    self.cardButtons[index].backgroundColor = self.theme.cardForegroundColor
                    self.cardButtons[index].alpha = 1
                    let attrString = NSAttributedString(string: self.emojisMapper[self.game.cards[index].id]!, attributes: [.font : self.font])
                    self.cardButtons[index].setAttributedTitle(attrString, for: .normal)
                   },
                   completion: nil)
  }
  
  private func flipFaceDown(_ index: Int) {
    UIView.transition(with: cardButtons[index],
                      duration: cardFlipDurationInSeconds,
                      options: .transitionFlipFromRight,
                      animations: { [weak self] in guard let self = self else { return }
                        self.cardButtons[index].backgroundColor = self.theme.cardBackgroundColor
                        self.cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                        self.cardButtons[index].alpha = 1
                      },
                      completion: nil)
  }
  
  private func removeCard(_ index: Int) {
    UIView.animate(withDuration: cardFlipDurationInSeconds,
                   delay: cardFlipDelayInSeconds,
                   options: [],
                   animations: { [weak self] in guard let self = self else { return }
                    self.cardButtons[index].alpha = 0
                   },
                   completion: nil)
  }
}
