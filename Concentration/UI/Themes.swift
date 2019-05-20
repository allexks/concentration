//
//  Themes.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 20.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit




class Themes {
  private init() {}
  static let shared = Themes()
  
  struct Theme {
    let emojiString: String
    var appBackgroundColor: UIColor
    var cardBackgroundColor: UIColor
    var cardForegroundColor: UIColor
    var scoreLabelTextColor: UIColor
    
    init(_ emojiString: String, appBackgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackgroundColor: UIColor = #colorLiteral(red: 0.9993161559, green: 0.5778841972, blue: 0.001107421704, alpha: 1), cardForegroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), scoreLabelTextColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
      self.emojiString = emojiString
      self.appBackgroundColor = appBackgroundColor
      self.cardBackgroundColor = cardBackgroundColor
      self.cardForegroundColor = cardForegroundColor
      self.scoreLabelTextColor = scoreLabelTextColor
    }
    
    func getRandomEmojis(emojisCount: Int) -> String {
      guard emojisCount > 0 && emojisCount <= emojiString.count else { return "" }
      
      let all = emojiString.map { String($0) }.shuffled()
      let result = all[..<emojisCount]
      
      return result.joined()
    }
  }
  
  let faces = Theme("😀😃😄😁😆😅☺️😂😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🤩🥳😏😒😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤬🤯😳🥵🥶😨😰😥😓🤗🤔🤭🤫🤥😶😐😑😬🙄😯😦😧😮😲😴🤤😪😵🤐🥴🤢🤧😷🤒🤕🤑")
  let japanEasy = Theme("👹👺🐡🐲🎋🌊🍜🍛🍣🍱🥟🍙🍚🍘🍥🥠🥮🥢🥡🚄🚝🚅🗼🏯⛩🏣🗾🎑💴🏮🎎🎏🧧💹💮💱🀄️🇯🇵🎌🎴", appBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardForegroundColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), scoreLabelTextColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
  let japanMedium = Theme( "👹👺🐡🐲🎋🌊🍜🍛🍣🍱🥟🍙🍚🍘🍥🥠🥮🥢🥡🚄🚝🚅🗼🏯⛩🏣🗾🎑💴🏮🎎🎏🧧💹💮💱🀄️🇯🇵🎌🎴🈳🈂️🈯️🈲🈴🈹🈵㊗️㊙️🉐🈷️🈺🈶🈚️🈸🉑🈁", appBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardForegroundColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), scoreLabelTextColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
  let japanHard = Theme("🈳🈂️🈯️🈲🈴🈹🈵㊗️㊙️🉐🈷️🈺🈶🈚️🈸🉑🈁", appBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardForegroundColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), scoreLabelTextColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
  let flags = Theme( "🏳️‍🌈🇺🇳🇦🇫🇦🇽🇦🇱🇩🇿🇦🇸🇦🇩🇦🇶🇦🇬🇦🇷🇦🇺🇦🇼🇦🇲🇦🇹🇦🇿🇧🇸🇧🇧🇧🇩🇧🇭🇧🇾🇧🇪🇧🇿🇧🇹🇧🇲🇧🇯🇧🇴🇧🇦🇧🇼🇻🇬🇮🇴🇧🇷🇧🇳🇧🇬🇧🇫🇨🇲🇰🇭🇧🇮🇨🇦🇨🇻🇨🇫🇰🇾🇧🇶🇹🇩🇨🇱🇨🇳🇨🇴🇨🇨🇨🇽🇰🇲🇨🇬🇨🇩🇨🇮🇨🇷🇨🇰🇭🇷🇨🇺🇨🇼🇩🇰🇨🇿🇨🇾🇩🇯🇩🇲🇩🇴🇸🇻🇪🇬🇪🇨🇬🇶🇪🇷🇪🇪🇫🇰🇪🇺🇪🇹🇫🇴🇫🇯🇫🇮🇬🇫🇫🇷🇹🇫🇬🇦🇬🇲🇬🇭🇩🇪🇬🇪🇬🇮🇬🇷🇬🇱🇬🇺🇬🇵🇬🇩🇬🇹🇬🇬🇬🇳🇭🇹🇬🇾🇬🇼🇭🇳🇭🇰🇭🇺🇮🇸🇮🇳🇮🇩🇮🇪🇮🇶🇮🇷🇮🇲🇮🇱🇮🇹🇯🇵🇯🇲🇯🇪🇯🇴🇰🇿🇽🇰🇰🇮🇰🇪🇰🇼🇰🇬🇱🇦🇱🇸🇱🇧🇱🇷🇱🇾🇱🇮🇲🇴🇱🇺🇱🇹🇲🇰🇲🇬🇲🇼🇲🇱🇲🇻🇲🇾🇲🇹🇲🇭🇲🇶🇾🇹🇲🇺🇲🇷🇲🇽🇫🇲🇲🇩🇲🇪🇲🇳🇲🇨🇲🇸🇲🇦🇲🇿🇳🇷🇳🇦🇳🇵🇳🇱🇳🇨🇳🇪🇳🇮🇳🇿🇳🇬🇳🇺🇳🇫🇳🇴🇲🇵🇰🇵🇴🇲🇵🇰🇵🇼🇵🇬🇵🇦🇵🇸🇵🇾🇵🇪🇵🇭🇵🇹🇵🇱🇵🇳🇵🇷🇶🇦🇷🇪🇷🇼🇷🇺🇷🇴🇼🇸🇸🇲🇸🇹🇷🇸🇸🇳🇸🇦🇸🇨🇸🇱🇸🇬🇸🇮🇸🇰🇸🇽🇬🇸🇸🇧🇸🇴🇸🇸🇰🇷🇿🇦🇪🇸🇱🇰🇧🇱🇸🇭🇵🇲🇻🇨🇸🇩🇸🇪🇸🇿🇸🇷🇨🇭🇸🇾🇹🇼🇹🇭🇹🇿🇹🇯🇹🇬🇹🇰🇹🇳🇹🇹🇹🇴🇹🇷🇹🇲🇹🇨🇺🇬🇻🇮🇹🇻🇺🇦🇦🇪🇬🇧🏴󠁧󠁢󠁷󠁬󠁳󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁥󠁮󠁧󠁿🇺🇸🇺🇿🇻🇪🇻🇦🇻🇺🇻🇳🇼🇫🇪🇭🇿🇼🇿🇲🇾🇪", appBackgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), cardBackgroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), cardForegroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), scoreLabelTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
}
