import SpriteKit


//OptionSet предназначен для работы с битовыми масками для групировки масок
struct BitMackCategory: OptionSet {
    let rawValue: UInt32

    
    static let none    = BitMackCategory(rawValue: 0 << 0) // 000000...000 ничего себя не включает
    static let player  = BitMackCategory(rawValue: 1 << 0) // 000000...1  1
    static let enemy   = BitMackCategory(rawValue: 1 << 1)   // 000000...10  2
    static let powerUp = BitMackCategory(rawValue: 1 << 2)   // 000000...100  4
    static let shot    = BitMackCategory(rawValue: 1 << 3)   // 000000...1000  8
    static let all     = BitMackCategory(rawValue: UInt32.max) // все значения
    
}


//для работы с категориями
extension SKPhysicsBody {
    
    var category: BitMackCategory { //
        get {
            return BitMackCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
    
}


//struct BitMackCategory {
//
//    static let player: UInt32  = 0x1 << 0 // 000000...1  1
//    static let enemy: UInt32   = 0x1 << 1   // 000000...10  2
//    static let powerUp: UInt32 = 0x1 << 2   // 000000...100  4
//    static let shot: UInt32    = 0x1 << 3   // 000000...1000  8
//
//}
