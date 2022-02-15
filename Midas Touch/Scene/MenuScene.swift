
import SpriteKit

class MenuScene: PerentScene {
    override func didMove(to view: SKView) {
        
        if !Assets.shared.isLoaded{
            Assets.shared.preloadAssets()//подгрузка всех текстур
            Assets.shared.isLoaded = true
        }
        
//        let background = SKSpriteNode(imageNamed: "backgroundMenu")
//        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        background.size = self.size // растянули фон на весь экран
//        background.zPosition = 0
//        self.addChild(background) // добавили фон на нашу сцену
        
        setHeader(withName: nil, andBackground: "header1", positionY: 200, positionX: 0)
        
//        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)//фон
        
//        let header = SKSpriteNode(imageNamed: "header1")
//
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)//размещаем по середине
//        self.addChild(header)//добавляем на сцену
        
        //setHeader(withName: nil, andBackground: "header1")
        
        let titles = ["play", "options", "best"] // текст для кнопок
        
        for (index, title) in titles.enumerated() {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background", fontSize: nil)
            // CGFloat(100 * index) смещаем по у в зависимости от индекса кнопки
            button.position = CGPoint(x: self.frame.midX, y: (self.frame.midY + 20) - CGFloat(50 * index))
            button.name = title
            button.zPosition = 2
           // button.setScale(0.3)
            button.label.name = title // такео же имя как и у самой кнопки что бы при нажатии все работало
            addChild(button)
            
        }
        
        
        
        let infoButton = ButtonNode(titled: "!", backgroundName: "button_background", fontSize: 40)
        
        infoButton.position = CGPoint(x: self.frame.maxX - 50, y: self.frame.maxY - 50)
        infoButton.size.width = infoButton.size.height
        infoButton.zPosition = 1
        infoButton.name = "info"
        infoButton.label.name = "info"
        infoButton.setScale(0.7)
        addChild(infoButton)
        
        let supportButton = ButtonNode(titled: "?", backgroundName: "button_background", fontSize: 40)
        
        supportButton.position = CGPoint(x: self.frame.minX + 50, y: self.frame.maxY - 50)
        supportButton.size.width = supportButton.size.height
        supportButton.zPosition = 1
        supportButton.name = "support"
        supportButton.label.name = "support"
        supportButton.setScale(0.7)
        addChild(supportButton)
//
//        let button2 = ButtonNode(titled: "options", backgroundName: "button_background")
//        button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
//        button2.name = "options"
//        button2.label.name = "options"
//        addChild(button2)
//
//        let button3 = ButtonNode(titled: "best", backgroundName: "button_background")
//        button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
//        button3.name = "best"
//        button3.label.name = "best"
//        addChild(button3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)//получаем кординаты касания
        let node = self.atPoint(location)//получаем нод по которому пришло касание
        
        //если нод которое коснулись кнопка то играем
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let gameScene = GameScene(size: self.size)//сцена на которую будем переходить
            gameScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(gameScene, transition: transition)//сам переход
            
        } else if node.name == "options" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self // устанавливаем эту сцену для кнопки back  с момощу которой мы вернемся
            optionsScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(optionsScene, transition: transition)//сам переход
            
        } else if node.name == "best" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self // устанавливаем эту сцену для кнопки back  с момощу которой мы вернемся
            bestScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(bestScene, transition: transition)//сам переход
        }else if node.name == "info" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            let infoScene = InfoScene(size: self.size)
            infoScene.backScene = self // устанавливаем эту сцену для кнопки back  с момощу которой мы вернемся
            infoScene.scaleMode = .aspectFill // на весь экран
            self.scene?.view?.presentScene(infoScene, transition: transition)//сам переход
        }else if node.name == "support" {
            let urlAsk = "https://forms.gle/JhmiHZDeXRoQDeGt5"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
            vc.url =  URL(string: urlAsk)
            vc.view.frame = self.view!.frame
            
            vc.backToGame = true
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.view?.window?.rootViewController?.present(vc, animated: true, completion: nil)
//            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
//            let infoScene = InfoScene(size: self.size)
//            infoScene.backScene = self // устанавливаем эту сцену для кнопки back  с момощу которой мы вернемся
//            infoScene.scaleMode = .aspectFill // на весь экран
//            self.scene?.view?.presentScene(infoScene, transition: transition)//сам переход
        }
        
        
        
    }
}
