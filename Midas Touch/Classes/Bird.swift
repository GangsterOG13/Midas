import SpriteKit
import GameplayKit

final class Bird: SKSpriteNode, GameBackgroundSpriteable {
    
    static var movementSpeed: CGFloat = 100.0 // скорость движения
    
    static func populate(at point: CGPoint?) -> Bird {
        
        let birdImageName = configureName()// рандомное название
        let bird = Bird(imageNamed: birdImageName)//создаем спрайт
        bird.setScale(randomScaleFactor)// задаем рандомный размер
        bird.position = point ?? randomPoint()// позиция
        bird.zPosition = 1
        bird.name = "sprite"
        bird.anchorPoint = CGPoint(x: 0.5, y: 1.0)

      //  bird.run(rotateForRandomAngle()) // поворачиваем остров
        bird.run(move(from: bird.position)) // движение острова
        
        return bird
        
    }
    //картинка  острова
    fileprivate static func configureName() -> String {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 5) // объект с диапазоном для рандома
        let randomNumber = distribution.nextInt() // возвращает рандомное число 
        let imageName = "bird_01"
        return imageName
        
    }
    //размер острова
    fileprivate static var randomScaleFactor: CGFloat {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 40
        return randomNumber
        
    }
    //поворот острова
    fileprivate static func rotateForRandomAngle() -> SKAction {
        
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(byAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
        
    }
    // движение острова
    fileprivate static func move(from point: CGPoint) -> SKAction{
        
        let movePoint = CGPoint(x: point.x, y: -200) // точка куда будет двигаться обьект
        let moveDistance = point.y + 200 // дистанция для нахождения скорости
        let duration = moveDistance / self.movementSpeed // время прохождения дистации
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
        
    }
    
}
