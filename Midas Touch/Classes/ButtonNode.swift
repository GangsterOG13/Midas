import SpriteKit


class ButtonNode: SKSpriteNode {

    let label: SKLabelNode = {
        let l = SKLabelNode(text: "")
        l.fontColor = UIColor(red: 0 / 255, green: 191 / 255, blue: 255 / 255, alpha: 1.0)
        l.fontName = "AmericanTypewriter-Bold"
        l.fontSize = 22
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center 
        l.zPosition = 2
        l.numberOfLines = 0
        return l
    }()
    
    init(titled title: String?, backgroundName: String, fontSize: CGFloat?){
        let texture = SKTexture(imageNamed: backgroundName)
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 3, height: texture.size().height / 3))
        if let title = title {
            label.text = title.uppercased()
        }
        if let fontSize = fontSize {
            label.fontSize = fontSize
        }
        
        addChild(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
