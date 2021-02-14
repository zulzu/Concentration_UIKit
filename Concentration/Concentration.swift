
import Foundation

struct Concentration {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    
    // # Private/Fileprivate
    private(set) var cards: Array = [Card]()
    private var indexOfSingleFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
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
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfSingleFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfSingleFaceUpCard = index
            }
        }
    }
    
    func choseCardFaceSet(usableSets: Array<String>) -> String {
        let randomEmojiCollection = usableSets.count.arc4random
        return usableSets[randomEmojiCollection]
    }
    
    mutating func resetCards(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.resetCards(at: \(index)): chosen index not in the cards")
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
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
