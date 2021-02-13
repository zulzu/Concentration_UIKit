
import Foundation

struct Card {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var identifier: Int
    
    // # Private/Fileprivate
    private static var uniqueIdentifier = 0
    
    //=======================================
    // MARK: Public Methods
    //=======================================
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
