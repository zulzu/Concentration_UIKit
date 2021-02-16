
import UIKit

class ViewController: UIViewController {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // # Private/Fileprivate
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private(set) var score: Int = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    
    private var emoji: Dictionary = [Card : String]()
    
    private var emojiSet = CardSet()

    private lazy var emojiSetInUse = emojiSet.getCardSet()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not in the cardButtons array")
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiSetInUse = emojiSet.getCardSet()
        updateViewFromModel()
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    
    //=======================================
    // MARK: Private Methods
    //=======================================
    private func updateViewFromModel() {
        flipCount = game.flipCount
        score = game.score
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiSetInUse.count > 0 {
            let randomStringIndex = emojiSetInUse.index(emojiSetInUse.startIndex, offsetBy: emojiSetInUse.count.arc4random)
            emoji[card] = String(emojiSetInUse.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "card missing"
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth: 2.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth: 2.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Score: \(score)\(game.isGameFinished ? ",\ngame completed!" : "")", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
}
