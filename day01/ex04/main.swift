let deck = Deck(withMixing: true)
print("all cards of deck:")
print(deck)

for index in 0..<60 {
    print("\n draw")
    let card = deck.draw()
    print(card ?? "nil")
    print("\n fold")
    if let card = card {
        deck.fold(c: card)
    }
    if index % 10 == 0 {
        print("\n\nall cards of deck:")
        print(deck)
        print("\n\ndiscard:")
        print(deck.discards)
        print("\n\nouts:")
        print(deck.outs)
    }
}
