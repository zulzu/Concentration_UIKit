
import Foundation

struct Card: Hashable {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    // # Private/Fileprivate
    private var id: UUID
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //------------------------------------
    // MARK: Initilisers
    //------------------------------------
    init() {
        self.id = UUID()
    }
    
    //=======================================
    // MARK: Private Methods
    //=======================================
}
