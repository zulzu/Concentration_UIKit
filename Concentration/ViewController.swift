
import UIKit

class ViewController: UIViewController {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices: Array<String> = ["👻", "🎃", "🙀", "☠️", "😈", "⚰️", "👹", "👺", "💀", "🧟‍♀️", "🧟‍♂️"]
    var emoji: Dictionary = [Int: String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("Card number = \(cardNumber)")
        } else {
            print("Chocen card is not in the cardButtons array")
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    func updateViewFromModel() {
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
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "card missing"
    }
}
