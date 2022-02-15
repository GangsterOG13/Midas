
import SpriteKit


//Супер класс для бонусов
class PowerUp: SKSpriteNode {
    fileprivate let initialSize = CGSize(width: 52, height: 52) // размер бонуса
   // fileprivate let textureNode: SKTexture!  // текстура
    fileprivate var textureNameBeingWith = "" // имя текстур
    fileprivate var animationSpriteArray = [SKTexture]()//масив текстур для анимации
    
    init(textureNode: SKTexture){

        let texture = textureNode//текстура
        super.init(texture: texture, color: .clear, size: initialSize)//создаем прайт
        self.setScale(0.7) // размер спрайта
        self.name = "sprite"//имя
        self.zPosition = 20
        self.zRotation = CGFloat.pi / 2
        
        // создаем физическое тело с уровнем прозрачности для боле приблеженой формы нода
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true // что бы при взаимодействии с другими обьектами ldbufkcz
        self.physicsBody?.categoryBitMask = BitMackCategory.powerUp.rawValue //категория битовой маски
        self.physicsBody?.collisionBitMask = BitMackCategory.player.rawValue  // обьекты с которыми будем сталкиваться
        self.physicsBody?.contactTestBitMask = BitMackCategory.player.rawValue  // регистрация столкнования с обьектами
        
    }
    
    func startMovement(){
        performRotation()
        
        let moveForward = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForward)
    }
    
    fileprivate func performRotation() {
        // Создаем Delay для  ноды в зависимости от
            let delayAction = SKAction.wait(forDuration: 0.2)
        
        // Анимация увеличения, а затем уменьшения
            let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
            let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        
        // Ожидание в 2 секунды, прежде чем повторить Action
            let waitAction = SKAction.wait(forDuration: 2)
        // ПОворот
            let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: 0.6)
        
           
        // Формируем Sequence (последовательность) для SKAction
        let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction, rotateAction, waitAction])
   
        // Создаем Action для повторения нашей последовательности
        let repeatAction = SKAction.repeatForever(scaleActionSequence)
   
        // Комбинируем 2 SKAction: Delay и Repeat
        let actionSequence = SKAction.sequence([delayAction, repeatAction])
   
        // Запускаем итоговый SKAction
        self.run(actionSequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
