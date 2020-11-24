import Foundation

class Deck: NSObject {
    
    var cards: [Card]
    var discards: [Card]
    var outs: [Card]
    
    init(withMixing mixing: Bool){
        self.cards = Deck.allCards
        self.discards = []
        self.outs = []
        if mixing {
            cards.mixCards()
        }
    }
    
    func draw() -> Card? {
        if !cards.isEmpty {
            let removedCard = cards.removeFirst()
            outs.append(removedCard)
            return removedCard
        }
        return nil
    }
    
    func fold(c: Card) {
        guard let cardIndex = outs.firstIndex(of: c) else {return}
        discards.append(c)
        outs.remove(at: cardIndex)
    }
    
    override var description: String {
        let descriptionArray = self.cards.map{$0.description}
        return descriptionArray.joined(separator:"\n")
    }
    
    static let allSpades:[Card] =
        Value.allValues.map{
            Card(withColor: .Spade, andValue: $0)
        }
    
    static let allDiamonds:[Card] =
        Value.allValues.map{
            Card(withColor: .Diamond, andValue: $0)
        }
    
    static let allHearts:[Card] =
        Value.allValues.map{
            Card(withColor: .Heart, andValue: $0)
        }
    
    static let allClubs:[Card] =
        Value.allValues.map{
            Card(withColor: .Clubs, andValue: $0)
        }
    
    static let allCards:[Card] =
        allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func mixCards() {
        let count = self.count
        for index in 0..<count {
            let indexForSwap = Int.random(in: 0..<count)
            let tmp = self[index]
            self[index] = self[indexForSwap]
            self[indexForSwap] = tmp
        }
    }
}
