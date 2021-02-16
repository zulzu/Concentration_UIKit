
import Foundation

struct Concentration {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    // To check if the game is finished
    var isGameFinished: Bool {
        for index in cards.indices {
            if !cards[index].isMatched { return false }
        }
        return true
    }
    
    // # Private/Fileprivate
    // The cards in the game
    private(set) var cards: Array = [Card]()
    // The score the user has at a given moment
    private(set) var score = 0
    // The number of the card flips the user did
    private(set) var flipCount = 0
    // To check if there is only one card flipped
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
    // The cards the user already flipped in the active game
    private var checkedCards = Set<Int>()

    //=======================================
    // MARK: Public Methods
    //=======================================
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
                
        updateFlipCount(tappedCard: index)
        
        if checkedCards.contains(index) && indexOfSingleFaceUpCard != index {
            score -= 1
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfSingleFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                }
                cards[index].isFaceUp = true
            } else {
                indexOfSingleFaceUpCard = index
            }
        }
        checkedCards.insert(index)
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
    
    //=======================================
    // MARK: Private Methods
    //=======================================
    private mutating func updateFlipCount(tappedCard: Int) {
        if tappedCard != indexOfSingleFaceUpCard {
            flipCount += 1
        }
    }
}
