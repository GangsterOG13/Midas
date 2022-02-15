import SpriteKit

class InfoScene: PerentScene {
    
    var places: [Int]!
    
    override func didMove(to view: SKView) {
        

//        let header = ButtonNode(titled: "best", backgroundName: "header_background")
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 250)//размещаем по середине
//        self.addChild(header)//добавляем на сцену
        
       // setHeader(withName: "Info", andBackground: "scores", positionY: nil, positionX: nil)
        
        
        
        //кнопка back
        let infoText =
        """
            Space Shot is a great game where you can while away a lot of time and enjoy the bonuses caught and enemies killed.
            Your spaceship flies in space and picks up speed, and the faster you fly, the more careful you need to be, since enemy ships will meet on your way and you need to destroy them, but for each shot you need a certain time to reload.
            Control your spaceship by tilting your phone, and to shoot you just need to touch the screen.
            Good luck and fun with Space Shot!
        """
        var fintSize: CGFloat = 16
        var hSize: CGFloat = 200
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                fintSize = 16
                hSize = 300
            case .pad:
                fintSize = 32
                hSize = 400
            default:
                break
            }
   
        let info = ButtonNode(titled: infoText, backgroundName: "scores2", fontSize: fintSize)
        info.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 20 )
        info.name = "info"
        info.size = CGSize(width: self.frame.size.width - 40, height: self.frame.size.height - hSize)
        info.label.name = "info"
        info.label.preferredMaxLayoutWidth = info.size.width - 30
        info.zPosition = 2

        addChild(info)
      
        
        //кнопка back
        let back = ButtonNode(titled: "back", backgroundName: "button_background", fontSize: nil)
        back.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 70)
        back.name = "back"
        back.label.name = "back"
        back.zPosition = 3
        back.setScale(0.8)
        addChild(back)
        
        //кнопка back
//        let infoText = "back"
//        let info = ButtonNode(titled: infoText, backgroundName: "button_background")
//        info.position = CGPoint(x: self.frame.midX, y: self.frame.minY )
//        info.name = "info"
//        info.size = CGSize(width: self.frame.size.width - 80, height: self.frame.size.height - 300)
//        info.label.name = "info"
//
//        addChild(back)
            
//        // сортируем масив результатов и оставлем 3 лучших
//        let topPlaces = places.sorted{$0 > $1}.prefix(3)
        
        //лейбл на кнопке
//        
//            let l = SKLabelNode(text: "info") // текст
//            l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0) // цвет
//            l.fontName = "AmericanTypewriter-Bold"//шрифт
//            l.fontSize = 24//размер
//        
//            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY )
//            addChild(l)
        
        
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
