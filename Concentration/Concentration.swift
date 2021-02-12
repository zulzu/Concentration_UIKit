
import Foundation

class Concentration {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var cards: Array = [Card]()
    var indexOfSingleFaceUpCard: Int?
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfSingleFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfSingleFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfSingleFaceUpCard = index
            }
        }
    }
    
    //------------------------------------
    // MARK: Initilisers
    //------------------------------------
    init(numberOfPairOfCards: Int) {
        
        for _ in 0..<numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
}
