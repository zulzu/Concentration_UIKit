
import Foundation

struct Card {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var identifier: Int
    static var uniqueIdentifier = 0
        
    //=======================================
    // MARK: Public Methods
    //=======================================
    static func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    //------------------------------------
    // MARK: Initilisers
    //------------------------------------
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
