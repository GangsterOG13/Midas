import SpriteKit

class PauseScene: PerentScene {
    
    override func didMove(to view: SKView) {

        
        setHeader(withName: "pause", andBackground: "scores", positionY: 200, positionX: nil)
        
        let titles = ["restart", "options", "resume"] // текст для кнопок
        
        for (index, title) in titles.enumerated() {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background", fontSize: nil)
            // CGFloat(100 * index) смещаем по у в зависимости от индекса кнопки
            button.position = CGPoint(x: self.frame.midX, y: (self.frame.midY + 20) - CGFloat(50 * index))
            button.name = title
            button.label.name = title // такео же имя как и у самой кнопки что бы при нажатии все работало
            button.zPosition = 4
            addChild(button)
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //фикс бага с паузой
        // если мы в меню пацзы но gameScene.isPaused == false  то меняем сразу на true
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused  {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)//получаем кординаты касания
        let node = self.atPoint(location)//получаем нод по которому пришло касание
        
        //если нод которое коснулись кнопка то играем
        if node.name == "restart" {
            sceneManager.gameScene = nil // удаляем сцену что бы начать игру заново
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let gameScene = GameScene(size: self.size)//сцена на которую будем переходить
            gameScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(gameScene, transition: transition)//сам переход
            
        } else if node.name == "options" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(optionsScene, transition: transition)//сам переход
            
        } else if node.name == "resume" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            //возвращаемся на сцену с игрой с помощу синглтона
            guard let gameScene = sceneManager.gameScene else {return}
            gameScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(gameScene, transition: transition)//сам переход
            
        }
        
    }
}
