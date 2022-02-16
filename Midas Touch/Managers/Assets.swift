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
        
        yellowShotAtlas.preload { }
        enemy_1Atlas.preload { }
        greenPowerUpAtlas.preload { }
        bluePowerUpAtlas.preload { }
        godPlaneAtlas.preload { }
        
    }
    
    
}
