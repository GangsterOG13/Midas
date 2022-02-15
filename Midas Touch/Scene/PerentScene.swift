import SpriteKit

class PerentScene: SKScene {
    
    let gameSettings = GameSettings()
    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    
    
    
    func setHeader(withName name: String?, andBackground backgroundName: String, positionY: CGFloat?, positionX: CGFloat?){
        
        let header = ButtonNode(titled: name, backgroundName: backgroundName, fontSize: nil)
        if positionY != nil &&  positionX != nil{
            header.position = CGPoint(x: self.frame.midX + positionX!, y: self.frame.maxY - positionY!)//размещаем по середине
        }else if positionY != nil &&  positionX == nil{
            header.position = CGPoint(x: self.frame.midX + 5, y: self.frame.maxY - positionY!)//размещаем по середине
        }else if positionX != nil &&  positionY == nil{
            header.position = CGPoint(x: self.frame.midX + positionX!, y: self.frame.maxY - 70)//размещаем по середине
        }else{
            header.position = CGPoint(x: self.frame.midX + 5, y: self.frame.maxY - 70)//размещаем по середине
        }
        
        
       
        header.zPosition = 3
        header.setScale(1.5)
        self.addChild(header)//добавляем на сцену
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        let background = SKSpriteNode(imageNamed: "backgroundMenu2")
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        background.size = self.size // растянули фон на весь экран
        background.zPosition = 0
        
        self.addChild(background) // добавили фон на нашу сцену
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
