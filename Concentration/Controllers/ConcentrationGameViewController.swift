//
//  ConcentrationGameViewController.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

class ConcentrationGameViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var cardButtons: [UIButton]!
  
  
  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for cardButton in cardButtons {
      cardButton.backgroundColor = .orange
      cardButton.setTitle("", for: .normal)
    }
  }
}
