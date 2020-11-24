let colors = Color.allColors
let values = Value.allValues

for color in colors {
    for value in values {
        print("\(color.rawValue) \(value.rawValue)")
    }
}
