import Foundation

class Deck: NSObject {
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
