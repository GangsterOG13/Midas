import SpriteKit
import GameplayKit


final class Star: SKSpriteNode, GameBackgroundSpriteable {
    
    static var movementSpeed: CGFloat = 150.0

    static func populate(at point: CGPoint?) -> Star {
        
        let starImageName = configureImage()// рандомное название
        let star = Star(imageNamed: starImageName)//создаем спрайт
        star.setScale(randomScaleFactor)// задаем рандомный размер
        star.position = point ?? randomPoint() // позиция
        star.zPosition = 10
        star.name = "sprite"
        star.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        star.run(move(from: star.position))
        return star
        
    }
    //картинка  облака
    fileprivate static func configureImage() -> String {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3) // объект с диапазоном для рандома
        let randomNumber = distribution.nextInt() // возвращает рандомное число
        let imageName = "cloud" + "\(randomNumber)"
        return imageName
        
    }
    //размер облака
    fileprivate static var randomScaleFactor: CGFloat {
        
        let distribution = GKRandomDistribution(lowestValue: 2, highestValue: 4)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        return randomNumber
        
    }
    // движение облака
    fileprivate static func move(from point: CGPoint) -> SKAction{
        
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        //self.movementSpeed = 150.0
        let duration = moveDistance / self.movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
        
    }
}


