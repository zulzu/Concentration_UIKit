
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
    var emoji: Dictionary = [Int: String]()
    var emojiHalloween: Array<String> = ["👻", "🎃", "🙀", "☠️", "😈", "⚰️", "👹", "👺", "💀", "🧟‍♀️", "🧟‍♂️"]
    var emojiAnimals: Array<String> = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🐷", "🐯", "🐸"]
    var emojiSports: Array<String> = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓"]
    var emojiFlags: Array<String> = ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🏳️‍🌈", "🇺🇳", "🇦🇶", "🇪🇺", "🎌", "🇻🇦"]
    var emojiFaces: Array<String> = ["🥳", "🤩", "😎", "🤯", "🥺", "🤫", "🙄", "😴", "🤐", "😷", "😵"]
    lazy var emojiSetInUse = game.choseEmojiSet(usableSets: [emojiHalloween, emojiAnimals, emojiSports, emojiFlags, emojiFaces])

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
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        for index in cardButtons.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        updateViewFromModel()
    }
    
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
        if emoji[card.identifier] == nil, emojiSetInUse.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiSetInUse.count)))
            emoji[card.identifier] = emojiSetInUse.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "card missing"
    }
}
