//
//  GameScene.swift
//  roulette
//
//  Created by Sebastián Silva García on 7/17/16.
//  Copyright (c) 2016 Sebastián Silva García. All rights reserved.
//

import SpriteKit
import SceneKit


class GameScene: SKScene {
    let sprite = SKSpriteNode(imageNamed:"Spaceship")
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Ruleta"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        
        
        /*Places the image and sets physic properties*/
        let location = CGPointMake(self.frame.width/2 , self.frame.height/2)
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 4.0)
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.physicsBody?.angularVelocity = 1.0
        sprite.physicsBody?.mass = 10
        self.addChild(sprite)
        
    }
    var numberOfTouches = 1
    var p1: CGPoint = CGPointMake(0, 0)
    var p2: CGPoint = CGPointMake(0, 0)
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {


        for touch in touches {
            
            switch numberOfTouches {
                
            case 1:
                numberOfTouches = 2
                p1 = touch.locationInNode(self)

            case 2:
                numberOfTouches = 0
                p2 = touch.locationInNode(self)
                
            default:
                numberOfTouches = 1
                //print("JUST BEFORE:  p1 = \(p1) y p2 = \(p2)")
                var velocity = getVelocityVector(p1, p2: p2)
                applyTorqueWithParameters(velocity, firstTouch: touch.locationInNode(self))
            }
            
        //print(touch.locationInNode(self))

        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            /*Obtiene dos puntos para llamar a getVelocityVector con dos argumentos*/
            print(touch.locationInNode(self))
        }
    }

    
    func applyTorqueWithParameters(velocity: CGPoint, firstTouch: CGPoint){
        let torqueMultiplicator: CGFloat = 0.01
        print("")
        if (firstTouch.x <= self.frame.width/2){
            //Si se aplica del lado izquierdo...
            if (velocity.y < 0){
                //Si el swipe fue hacia abajo
                sprite.physicsBody?.applyTorque(-velocity.y * (-torqueMultiplicator))
            }else{
                sprite.physicsBody?.applyTorque(velocity.y * torqueMultiplicator)

            }
        }
    }
    
    
    func getVelocityVector(p1: CGPoint, p2: CGPoint) -> CGPoint{
        //print("ENTRA A FUNCION VELOCIDAD. p1 = \(p1) y p2 = \(p2)")
        var velocity = CGPointMake(0, 0)
        velocity.x = p1.x - p2.x
        velocity.y = p1.y - p2.y
        //print ("VECTOR VELOCIDAD: \(velocity)")
        return velocity
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    

}
