import SpriteKit

class OptionsScene: PerentScene {
    
    var isMusic: Bool!
    var isSound: Bool!
    
    override func didMove(to view: SKView) {
        
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        
        setHeader(withName: "options", andBackground: "scores2", positionY: 150, positionX: nil)
        
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        
        //кнопка музыка
        let music = ButtonNode(titled: nil, backgroundName: backgroundNameForMusic, fontSize: nil)
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        music.name = "music"
        music.label.isHidden = true // спрятали лейбл
        music.zPosition = 2
        music.setScale(2)
        addChild(music)
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        //кнопка звук
        let sound = ButtonNode(titled: nil, backgroundName: backgroundNameForSound, fontSize: nil)
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        sound.name = "sound"
        sound.label.isHidden = true // спрятали лейбл
        sound.zPosition = 2
        sound.setScale(2)
        addChild(sound)
        
        //кнопка back
        let back = ButtonNode(titled: "back", backgroundName: "button_background", fontSize: nil)
        back.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 70)
        back.name = "back"
        back.label.name = "back"
        back.zPosition = 3
        back.setScale(0.8)
        addChild(back)
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)//получаем кординаты касания
        let node = self.atPoint(location)//получаем нод по которому пришло касание
        
        //если нод которое коснулись кнопка то играем
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
        } else if node.name == "back" {
            gameSettings.isMusic = isMusic
            gameSettings.isSound = isSound
            gameSettings.saveGameSettings()
            let transition = SKTransition.crossFade(withDuration: 1.0)// эфект для перехода на другую сцену
            guard let backScene = backScene else {return}
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)//сам переход
            
        }
        
    }
    
    func update(node: SKSpriteNode, property: Bool){
        
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
        
    }
}
