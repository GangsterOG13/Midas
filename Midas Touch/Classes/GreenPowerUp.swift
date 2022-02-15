import SpriteKit

class GreenPowerUp: PowerUp {
    init(){
        let texture = SKTexture(imageNamed: "shots")
        super.init(textureNode: texture)
        name = "greenPowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
