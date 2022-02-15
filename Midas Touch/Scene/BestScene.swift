import SpriteKit

class BestScene: PerentScene {
    
    var places: [Int]!
    
    override func didMove(to view: SKView) {
        
        gameSettings.loadScores()
        places = gameSettings.highscore
        
//        let background = SKSpriteNode(imageNamed: "backgroundMenu2")
//        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        background.size = self.size // растянули фон на весь экран
//        background.zPosition = 0
//        self.addChild(background) // добавили фон на нашу сцену
        
//
//        let header = ButtonNode(titled: "best", backgroundName: "header_background", fontSize: nil)
//        header.position = CGPoint(x: self.frame.midX + 10, y: self.frame.midY + 250)//размещаем по середине
//        header.zPosition = 1
//        self.addChild(header)//добавляем на сцену
        
        setHeader(withName: "top 3", andBackground: "scores2", positionY: 150, positionX: nil)

        
        
        

      
        
        //кнопка back
        let back = ButtonNode(titled: "back", backgroundName: "button_background", fontSize: nil)
        back.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 70)
        back.name = "back"
        back.label.name = "back"
        back.zPosition = 3
        back.setScale(0.8)
        addChild(back)
            
//        // сортируем масив результатов и оставлем 3 лучших
//        let topPlaces = places.sorted{$0 > $1}.prefix(3)
        
        //лейбл на кнопке
        for (index, value) in places.enumerated(){
            let l = SKLabelNode(text: value.description) // текст
            l.fontColor = .black // цвет
            l.fontName = "AmericanTypewriter-Bold"//шрифт
            l.fontSize = 30//размер
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            l.zPosition = 2
            addChild(l)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)//получаем кординаты касания
        let node = self.atPoint(location)//получаем нод по которому пришло касание
        
        //если нод которое коснулись кнопка то играем
       if node.name == "back" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            guard let backScene = backScene else {return}
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)//сам переход
            
        }
        
    }
}
