import SpriteKit

//Класс для выстрела
class Shot: SKSpriteNode {
    let screenSize = UIScreen.main.bounds
    fileprivate let initialSize = CGSize(width: 187, height: 237) // размер выстрела
    fileprivate let textureAtlas: SKTextureAtlas!  // текстура
    fileprivate var textureNameBeingWith = "" // имя текстур
    fileprivate var animationSpriteArray = [SKTexture]()//масив текстур для анимации
    
    init(textureAtlas: SKTextureAtlas){
        self.textureAtlas = textureAtlas// название атласа с текстурами
        let textureName = textureAtlas.textureNames.sorted()[0] // первый елемент из атласа
        let texture = textureAtlas.textureNamed(textureName)//текстура
        //let texture = SKTexture(imageNamed: "shot")
        textureNameBeingWith = String(textureName.dropLast(6))//откидываем последние 6 символов 01.png от первого файла текстуры
        super.init(texture: texture, color: .clear, size: initialSize)//создаем прайт
        self.setScale(1) // размер спрайта
        self.zRotation = CGFloat.pi / 2
        self.name = "shotSprite"//имя
        self.zPosition = 30
        
        
        // создаем физическое тело с уровнем прозрачности для боле приблеженой формы нода
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = false // что бы при взаимодействии с другими обьектами ldbufkcz
        self.physicsBody?.categoryBitMask = BitMackCategory.shot.rawValue //категория битовой маски
        self.physicsBody?.collisionBitMask = BitMackCategory.enemy.rawValue  // обьекты с которыми будем сталкиваться
        self.physicsBody?.contactTestBitMask = BitMackCategory.enemy.rawValue  // регистрация столкнования с обьектами
        
    }
    
    func startMovement(){
        performRotation()
        //выстрел
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
    }
    
    func startMovementBlack(){
        performRotation()
        //выстрел
        let moveForward = SKAction.moveTo(y: screenSize.minY - 100, duration: 1)
        self.run(moveForward)
    }

    
    
    fileprivate func performRotation() {
        //заполняем масив текстур спрайта
        for i in 1...10 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeingWith + number.description ))
        }
        //загружаем текстуры
        SKTexture.preload(animationSpriteArray){
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)// анимируем спрайт
            let rotationForever = SKAction.repeatForever(rotation) // бесконечная анимация
            self.run(rotationForever) // запускаем анимацию
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
