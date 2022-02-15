import SpriteKit
import CoreMotion

class PlayerGod: SKSpriteNode {
    
    let motionManager = CMMotionManager() // менеджер для аксилиратора/ повороты устройства
    var xAcceleration: CGFloat = 0// поворот для скорости
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // размер экрана
    var shotTextureArrayAnimation = [SKTexture]()//масивы для анимации
    
    fileprivate var textureNameBeingWith = "" // имя текстур
    fileprivate var animationSpriteArray = [SKTexture]()//масив текстур для анимации

    var stillTurning = false // закончилась ли анимация?

    //создаем самалет
    static func populate(at point: CGPoint) -> PlayerGod{
        let atlas = Assets.shared.godPlaneAtlas
        let playerGodTexture = atlas.textureNamed("god_01") //SKTexture(imageNamed: "airplane_3ver2_13")
        let playerGod = PlayerGod(texture: playerGodTexture)
        playerGod.setScale(0.3)
        playerGod.position = point
        playerGod.zPosition = 40
        

        
        // создаем физическое тело с уровнем прозрачности для боле приблеженой формы нода
        playerGod.physicsBody = SKPhysicsBody(texture: playerGodTexture, alphaThreshold: 0.5, size: playerGod.size)
        playerGod.physicsBody?.isDynamic = false // что бы при взаимодействии с другими обьектами самолет был как стена
        playerGod.physicsBody?.categoryBitMask = BitMackCategory.player.rawValue //категория битовой маски
        playerGod.physicsBody?.collisionBitMask = BitMackCategory.enemy.rawValue | BitMackCategory.powerUp.rawValue // обьекты с которыми будем сталкиваться
        playerGod.physicsBody?.contactTestBitMask = BitMackCategory.enemy.rawValue | BitMackCategory.powerUp.rawValue // регистрация столкнования с обьектами
        
        return playerGod
    }
    
    //проверка уходит ли самолет за граници
    func checkPosition() {
        
        self.position.x += xAcceleration * 20
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    // основной метод  анимация и полет
    func performFly() {
        //управление с помощью акселирометра
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.3 + self.xAcceleration * 0.2
            }
        }
        performRotation()
    }
    
    func shotAnimal(){
        preloadArray()
    }
    
    fileprivate func performRotation() {
        // Создаем Delay для  ноды в зависимости от
            let delayAction = SKAction.wait(forDuration: 1)
        
        // Анимация увеличения, а затем уменьшения
        let scaleUpAction = SKAction.scale(to: 0.3, duration: 1)
        let scaleDownAction = SKAction.scale(to: 0.25, duration: 0.5)
        
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

    fileprivate func preloadArray() {
        Assets.shared.godPlaneAtlas
        var array = [SKTexture]()
        for i in stride(from: 1, through: 4, by: 1) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "god_\(number)")
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
//    //заполняем масив для анимации
//    fileprivate func planeAnimationFillArray(){
//
//        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) { // предзагрузка текстур
//            self.leftTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, through: 1, by: -1){
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
//                    array.append(texture)
//                }
//
//                SKTexture.preload(array) {
//                    print("preload is done")
//                }
//                return array
//
//            }()
//
//            self.rightTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, through: 26, by: 1){
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
//                    array.append(texture)
//                }
//
//                SKTexture.preload(array) { // предзагрузка масива
//                    print("preload is done")
//                }
//                return array
//
//            }()
//
//            self.forwardTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
//                array.append(texture)
//                SKTexture.preload(array) {
//                    print("preload is done")
//                }
//                return array
//
//            }()
//
//        }
//
//    }
//
//    //определяет вкакую сторону запускать анимацию
//    fileprivate func movementDirectionCheck() {
//        print(xAcceleration)
//
//        if xAcceleration > 0.01, moveDirection != .right, stillTurning == false {
//            stillTurning = true
//            moveDirection = .right
//            turnPlane(direction: moveDirection)
//        }else if xAcceleration < -0.01, moveDirection != .left, stillTurning == false {
//            stillTurning = true
//            moveDirection = .left
//            turnPlane(direction: moveDirection)
//        }else if stillTurning == false{
//            moveDirection = .none
//            turnPlane(direction: moveDirection)
//        }
//
//    }
    //запуск анимации
//    fileprivate func turnPlane(direction: TurnDirection) {// анимация
//
//        var array = [SKTexture]()
//
//        if direction == .right {
//            array = rightTextureArrayAnimation
//        } else if direction == .left {
//            array = leftTextureArrayAnimation
//        }else {
//            array = forwardTextureArrayAnimation
//        }
//        //анимация в одну сторону (масив / интервал на каждый кадр/размер текстуры в зависимотсти от экрана/возврат к первому кадру)
//        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
//        //возврат в прежнее положение
//        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
//
//        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
//        self.run(sequenceAction) { [unowned self] in
//            self.stillTurning = false
//        }
//
//    }
    
    func greenPowerUp() {
        let colorAction = SKAction.colorize(with: .yellow, colorBlendFactor: 1.0, duration: 0.2)
        let uncolorAction = SKAction.colorize(with: .yellow, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction, uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 3)
        self.run(repeatAction)
    }
    
    func bluePowerUp() {
        let colorAction = SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 0.2)
        let uncolorAction = SKAction.colorize(with: .green, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction, uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 3)
        self.run(repeatAction)
    }
    
}
//определяем поворот
enum TurnDirection {
    case left
    case right
    case none
}
