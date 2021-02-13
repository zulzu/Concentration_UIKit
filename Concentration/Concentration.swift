
import Foundation

class Concentration {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var cards: Array = [Card]()

    // # Private/Fileprivate
    private var indexOfSingleFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfSingleFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfSingleFaceUpCard = index
            }
        }
    }
    
    func choseEmojiSet(usableSets: Array<Array<String>>) -> Array<String> {
        let randomEmojiCollection = Int(arc4random_uniform(UInt32(usableSets.count)))
        return usableSets[randomEmojiCollection]
    }
    
    //------------------------------------
    // MARK: Initilisers
    //------------------------------------
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init \(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
