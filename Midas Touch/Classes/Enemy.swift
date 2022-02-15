
import SpriteKit

class Enemy: SKSpriteNode {
    
    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    static var timeHorizontal = 3.0 // время полета по горизонтали
    static var timeVertical = 5.0 // время полета по вертикале
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // размер экрана
    var stillTurning = false // закончилась ли анимация?
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 225, height: 600))
//        self.xScale = 0.5 // уменьшаем в два раза
//        self.yScale = -0.5 // разварачиваем по оси y
        self.setScale(0.4)
        self.zPosition = 20
        self.name = "spriteEnemy"
        
        // создаем физическое тело с уровнем прозрачности для боле приблеженой формы нода
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true // что бы при взаимодействии с другими обьектами ldbufkcz
        self.physicsBody?.categoryBitMask = BitMackCategory.enemy.rawValue //категория битовой маски
        self.physicsBody?.collisionBitMask = BitMackCategory.none.rawValue // при столкновении ничего не делать
        self.physicsBody?.contactTestBitMask = BitMackCategory.player.rawValue | BitMackCategory.shot.rawValue // регистрация столкнования с обьектами
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flySpiral() {
        let timeHorizontal = Double.random(in: 2.5...3.5)
       // время полета по вертикале
        // движение  в лево 50 это половина нашего спрайта самолета
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut // плавное движение
        // движение  в право 50 это половина нашего спрайта самолета
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let rundomNumer = Int(arc4random_uniform(2))
        
        let asideMovementSequence = rundomNumer == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
       
        let asideMovementForever = SKAction.repeatForever(asideMovementSequence)
        
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: Enemy.timeVertical) // движение по горизонтали
        let groupMovement = SKAction.group([asideMovementForever, forwardMovement]) // групировка акшенов
        self.run(groupMovement)
        
        performRotation()
        
        
    }
    
    func shotAnimal(){
        preloadArray()
    }
    
    fileprivate func preloadArray() {
        Assets.shared.enemy_1Atlas
        var array = [SKTexture]()
        for i in stride(from: 1, through: 4, by: 1) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "blackGod_\(number)")
            array.append(texture)
        }

        //анимация в одну сторону (масив / интервал на каждый кадр/размер текстуры в зависимотсти от экрана/возврат к первому кадру)
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.02, resize: true, restore: false)
        //возврат в прежнее положение
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
        
       
    
    }
    
    fileprivate func performRotation() {
        // Создаем Delay для  ноды в зависимости от
            let delayAction = SKAction.wait(forDuration: 1)
        
        // Анимация увеличения, а затем уменьшения
        let scaleUpAction = SKAction.scale(to: 0.45, duration: 1)
        let scaleDownAction = SKAction.scale(to: 0.4, duration: 0.5)
        
        // Ожидание в 2 секунды, прежде чем повторить Action
        let waitAction = SKAction.wait(forDuration: 0.3)
   
        
           
        // Формируем Sequence (последовательность) для SKAction
        let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])
   
        // Создаем Action для повторения нашей последовательности
        let repeatAction = SKAction.repeatForever(scaleActionSequence)
   
        // Комбинируем 2 SKAction: Delay и Repeat
        let actionSequence = SKAction.sequence([delayAction, repeatAction])
   
        // Запускаем итоговый SKAction
        self.run(actionSequence)
    }
}

enum EnemyDirection: Int {
    case left = 0
    case rigth
}
