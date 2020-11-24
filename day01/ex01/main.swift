let card1 = Card(withColor: Color.Spade, andValue: Value.Ace)
print("card1: \(card1)")

let card2 = Card(withColor: Color.Diamond, andValue: Value.Two)
print("card2: \(card2)")

let card3 = Card(withColor: Color.Diamond, andValue: Value.Two)
print("card3: \(card3)")

print("card1 == card2:")
print(card1 == card2)
print("\ncard2 == card3:")
print(card2 == card3)
print("\ncard1 isEqual card3:")
print(card1.isEqual(to: card3))
print("\ncard3 isEqual card2:")
print(card3.isEqual(to: card2))
