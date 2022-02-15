import SpriteKit

class Assets {
    
    static let shared = Assets()
    var isLoaded = false
    let yellowShotAtlas = SKTextureAtlas(named: "YellowAmmo")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let godPlaneAtlas = SKTextureAtlas(named: "God_1")
    
    func preloadAssets(){
        
        yellowShotAtlas.preload { print("yellowShotAtlas preload")}
        enemy_1Atlas.preload { print("enemy_1Atlas preload")}
        greenPowerUpAtlas.preload { print("greenPowerUpAtlas preload")}
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas preload")}
        godPlaneAtlas.preload { print("godPlaneAtlas preload")}
        
    }
    
    
}
