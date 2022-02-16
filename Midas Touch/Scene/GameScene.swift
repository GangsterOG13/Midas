import SpriteKit
import GameplayKit


class GameScene: PerentScene {
    
    var backgroundMusic: SKAudioNode!
    
    fileprivate var speedGame: CGFloat = 1.0
    
    fileprivate var player: PlayerGod!
    fileprivate let hud = HUD()//елементы интерфейса
    fileprivate let screenSize = UIScreen.main.bounds.size
    
    fileprivate var lives = 3 {
        //наблюдатель за количеством жизней
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }

    var data = Date()
    
    
    override func didMove(to view: SKView) {
        gameSettings.loadGameSettings()
        
        if gameSettings.isMusic && backgroundMusic == nil {
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
            }
        }
        
        self.scene?.isPaused = false
        
        //checking if scene persister
        guard sceneManager.gameScene == nil else { return }
        sceneManager.gameScene = self // создаем сильную ссылку что бы сцена не удалялась когда ставим на паузу
        
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnStars()
        player.performFly()
        spawnPowerUp()
        spawnEnemies()
        createHUD()
        
        
    }
    
    fileprivate func createHUD(){
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    fileprivate func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 2.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        //можно записыват в одну строку, но не рекомендуеться
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    fileprivate func spawnPowerUp(){
        
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
        
        
    }
    
    fileprivate func spawnSpiralOfEnemies(){
        

            let texture = SKTexture(imageNamed: "blackGod_01")
            let waitAction = SKAction.wait(forDuration: 1.0) // задержка появления самолетов
            let spawnEnemy = SKAction.run { [unowned self] in
        
                Enemy.timeHorizontal = 3.0 - CGFloat(self.hud.score) / 1000
                Enemy.timeVertical = 5.0 - CGFloat(self.hud.score) / 1000
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
                enemy.setScale(0.5)
            }
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 1)
            
            self.run(repeatAction)
            
        }
        

    
    fileprivate func spawnStars() {
        
        let spawnStarWait = SKAction.wait(forDuration: TimeInterval(1 - (Double(self.hud.score) / 300)))
        let spawnStarAction = SKAction.run {
            Star.movementSpeed = CGFloat(self.hud.score) + 150.0
            let star = Star.populate(at: nil)
            self.addChild(star)
        }
        
        let spawnStarSequence = SKAction.sequence([spawnStarWait, spawnStarAction])
        let spawnStarForever = SKAction.repeatForever(spawnStarSequence)
        run(spawnStarForever)
        
    }
    
    fileprivate func spawnPlanets() {
        
        let spawnBirdWait = SKAction.wait(forDuration: TimeInterval(2 - (Double(self.hud.score) / 200)))
        let spawnBirdAction = SKAction.run {
            Bird.movementSpeed = CGFloat(self.hud.score) + 150.0
            let bird = Bird.populate(at: nil)
            self.addChild(bird)
        }
        
        let spawnBirdSequence = SKAction.sequence([spawnBirdWait, spawnBirdAction])
        let spawnBirdForever = SKAction.repeatForever(spawnBirdSequence)
        run(spawnBirdForever)
        
    }
    
    fileprivate func configureStartScene() {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2) // центр экрана
        let background = Background.populateBackground(at: screenCenterPoint) // фон
        background.size = self.size // растянули фон на весь экран
        self.addChild(background) // добавили фон на нашу сцену
        
        let screen = UIScreen.main.bounds // размер экрана
        
        player = PlayerGod.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
    }
    
    override func didSimulatePhysics() {
        player.checkPosition()
        enumerateChildNodes(withName: "sprite") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "spriteEnemy") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        
        enumerateChildNodes(withName: "shotSprite") { node, stop in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "bluePowerUp") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "greenPowerUp") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
    }
    
    fileprivate func playerFire(){
        let shot = YellowShot()
        let position = CGPoint(x: self.player.position.x - 30, y: self.player.position.y + 60)
        shot.position = position
        shot.startMovement()
        self.addChild(shot)
        //делаем паузу 1 с на взрыв
        player.shotAnimal()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let dataShot = Date()
        if Double(dataShot.timeIntervalSinceNow - self.data.timeIntervalSinceNow) < 0.5 {
            return
        }
        
        if gameSettings.isSound {
            self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
        }
    
        self.data = dataShot
        let location = touches.first!.location(in: self)//получаем кординаты касания
        let node = self.atPoint(location)//получаем нод по которому пришло касание
        
        //если нод которое коснулись кнопка то играем
        if node.name == "pause" {
            
            let transition = SKTransition.doorway(withDuration: 1.0)// эфект для перехода на другую сцену
            let pauseScene = PauseScene(size: self.size)//сцена на которую будем переходить
            pauseScene.scaleMode = .aspectFill // на весь экран
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene?.view?.presentScene(pauseScene, transition: transition)//сам переход
            
        } else {
            playerFire()
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        //создаем обьект с частицами взрыва
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        //определяем точку контакта
        let contactPoint = contact.contactPoint
        //устанавливаем взрыв в точке контакта
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        //делаем паузу 1 с на взрыв
        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
        
        
        let contactCategory : BitMackCategory = [contact.bodyA.category, contact.bodyB.category]
        //если категория содержить определеные обьекты то срабатывает определеный case
        switch contactCategory {
        case [.enemy, .player]:
            //удаляем врага
            if contact.bodyA.node?.name == "sprite" {
                // если еще есть родитель то столкновения еще не было иначе удаляем , проверка что бы фиксировали только 1 столкновение и снимало только 1 жизнь
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                    }
                    lives -= 1
                    if lives == 0 {
                        gameSettings.currentScore = hud.score
                        gameSettings.saveScores()
                        
                        //делаем паузу 1 с на взрыв
                        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
                        if gameSettings.isSound {
                            self.run(SKAction.playSoundFileNamed("gameOver", waitForCompletion: false))
                        }
                        //даем 1 секунду для взрыва и удалаем его
                        self.run(waitForExplosionAction) {
                            let gameOverScene = GameOver(size: self.size)
                            gameOverScene.scaleMode = .aspectFill // на весь экран
                            let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)// эфект для перехода на другую сцену
                            self.scene?.view?.presentScene(gameOverScene, transition: transition)//сам переход
                        }
                    }
                }
            }else{
                if contact.bodyB.node?.parent != nil {// если еще есть родитель то столкновения еще не было иначе удаляем
                    contact.bodyB.node?.removeFromParent()
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                    }
                    lives -= 1
                    if lives == 0 {
                        gameSettings.currentScore = hud.score
                        gameSettings.saveScores()
                        
                        //делаем паузу 1 с на взрыв
                        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
                        if gameSettings.isSound {
                            self.run(SKAction.playSoundFileNamed("gameOver", waitForCompletion: false))
                        }
                        //даем 1 секунду для взрыва и удалаем его
                        self.run(waitForExplosionAction) {
                            let gameOverScene = GameOver(size: self.size)
                            gameOverScene.scaleMode = .aspectFill // на весь экран
                            let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)// эфект для перехода на другую сцену
                            self.scene?.view?.presentScene(gameOverScene, transition: transition)//сам переход
                        }
                    }
                }
            }
            //добавляем взрыв на сцену
            addChild(explosion!)
            //даем 1 секунду для взрыва и удалаем его
            self.run(waitForExplosionAction) {
                explosion?.removeFromParent()
            }
            
            
            
        case [.powerUp, .player]:
           
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                
                if contact.bodyA.node?.name == "bluePowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                } else if contact.bodyB.node?.name == "bluePowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                }
                
                if contact.bodyA.node?.name == "greenPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    enumerateChildNodes(withName: "spriteEnemy") { node, stop in
                            node.removeFromParent()
                    }
                    player.greenPowerUp()
                } else if contact.bodyB.node?.name == "greenPowerUp" {
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                    }
                    
                    contact.bodyB.node?.removeFromParent()
                    enumerateChildNodes(withName: "spriteEnemy") { node, stop in
                        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
                        //определяем точку контакта
                        let contactPoint = node.position
                        //устанавливаем взрыв в точке контакта
                        explosion?.position = contactPoint 
                        explosion?.zPosition = 25
                        //делаем паузу 1 с на взрыв
                        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
                        //добавляем взрыв на сцену
                        self.addChild(explosion!)
                        //даем 1 секунду для взрыва и удалаем его
                        self.run(waitForExplosionAction) {
                            explosion?.removeFromParent()
                        }
                        node.removeFromParent()
                        
                    }
                    player.greenPowerUp()
                }
            }
        case [.enemy, .shot]:
            //удаляем врага
            // если еще есть родитель то столкновения еще не было иначе удаляем , проверка что бы фиксировали только 1 столкновение и снимало только 1 жизнь
            if contact.bodyA.node?.parent != nil {
                
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                 
                if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                
                hud.score += 10
                self.speedGame += 0.1
                //добавляем взрыв на сцену
                addChild(explosion!)
                //даем 1 секунду для взрыва и удалаем его
                self.run(waitForExplosionAction) {
                    explosion?.removeFromParent()
                }
            }
            
        default:
            preconditionFailure("Unable to detect collision category")//сообщение если не смогли определить категорию столкновения
        }
        
        //        let bodyA = contact.bodyA.categoryBitMask
        //        let bodyB = contact.bodyB.categoryBitMask
        //
        //        let player = BitMackCategory.player
        //        let enemy = BitMackCategory.enemy
        //        let shot = BitMackCategory.shot
        //        let powerUp = BitMackCategory.powerUp
        //
        //        if bodyA == player && bodyB == enemy || bodyB == player && bodyA == enemy {
        //            print("enemy vs player")
        //        } else if bodyA == player && bodyB == powerUp || bodyB == player && bodyA == powerUp {
        //            print("powerUp vs player")
        //        } else if bodyA == enemy && bodyB == shot || bodyB == enemy && bodyA == shot{
        //            print("enemy vs shot")
        //        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
