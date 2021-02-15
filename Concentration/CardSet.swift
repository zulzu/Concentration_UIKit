
import Foundation

class CardSet {
    
    enum CardSets: CaseIterable {
        
        case emojiHalloween
        case emojiAnimals
        case emojiSports
        case emojiFlags
        case emojiFaces
        
        var cardSetString: String {
            
            switch self {
            case .emojiHalloween:
                return "👻🎃🙀☠️😈⚰️👹👺💀🧟‍♀️🧟‍♂️"
            case .emojiAnimals:
                return "🐶🐱🐭🐰🦊🐻🐼🐨🐷🐯🐸"
            case .emojiSports:
                return "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓"
            case .emojiFlags:
                return "🏳️🏴🏴‍☠️🏁🚩🏳️‍🌈🇺🇳🇦🇶🇪🇺🎌🇻🇦"
            case .emojiFaces:
                return "🥳🤩😎🤯🥺🤫🙄😴🤐😷😵"
            }
        }
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    func getCardSet() -> String {
        return CardSets.allCases[CardSets.allCases.count.arc4random].cardSetString
    }
}
