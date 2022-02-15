import SpriteKit


// нужен что бы  сцена с игрой когда стоит на паузе сохраняла сильную ссылку и не удалялась и можно было вернуться на то место где играл

class SceneManager {
    
    static let shared = SceneManager()
    
    var gameScene: GameScene?
}
