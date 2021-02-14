
import Foundation

struct Card: Hashable {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    // # Private/Fileprivate
    private var identifier: Int
    private static var uniqueIdentifier = 0
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    //------------------------------------
    // MARK: Initilisers
    //------------------------------------
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //=======================================
    // MARK: Private Methods
    //=======================================
    private static func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
}
