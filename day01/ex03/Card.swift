import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    init(withColor color: Color, andValue value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description: String {
        return "(\(self.value.rawValue), \(self.color.rawValue))"
    }
    
    override func isEqual(to object: Any?) -> Bool {
        guard let object = object as? Card else {return false}
        return self == object
    }
    
    static func == (left: Card, right: Card) -> Bool {
        return left.color == right.color && left.value == right.value
    }
}
