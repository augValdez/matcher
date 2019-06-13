//
//  ViewController.swift
//  finalProject
//
//  Created by Augustine Valdez on 6/3/19.
//  Copyright © 2019 Augustine Valdez. All rights reserved.
//


// importing more than one kit
import UIKit
import Foundation
import SpriteKit
import CoreMotion



// GOAL OF GAME:

//  By tilting your phone to move the characters
//  you try and match the colored mario/luigi/goomba/or life
//  to the black and white image of mario/luigi/goomba/or life that is in the middle
//  once you match one (or more) of the characters to their matching black and white image
//  a little star will pop up at the top, once you have all 4 stars you win!

class ViewController: UIViewController {
    
    var mm : CMMotionManager = CMMotionManager()
    var sc : SKScene!
    var marioBW : SKSpriteNode!
    var luigiBW : SKSpriteNode!
    var goombaBW : SKSpriteNode!
    var lifeBW : SKSpriteNode!
    var mario : SKSpriteNode!
    var luigi : SKSpriteNode!
    var goomba : SKSpriteNode!
    var life : SKSpriteNode!
    var marioStar : SKSpriteNode!
    var luigiStar : SKSpriteNode!
    var lifeStar : SKSpriteNode!
    var goombaStar : SKSpriteNode!
    var winner : SKSpriteNode!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc = SKScene(size: view.frame.size)
        let sv = SKView(frame: view.frame)
     
        
        // Creating the timer
        let timeInput = TimeInterval(floatLiteral: 0.1)
        Timer.scheduledTimer(withTimeInterval: timeInput, repeats: true, block: block)
        
        
        mm.startAccelerometerUpdates(to: OperationQueue(), withHandler: accelHandler)
        view.addSubview(sv)
        

        //This is simply adding the image at the bottom of my display saying my name
        let name = SKSpriteNode(imageNamed: "augustine.png")
        name.size = CGSize(width: 385, height: 20)
        name.position = CGPoint(x: 0, y: -325)
        sc.addChild(name)
        
        
    //Creating the stars that pop up when you match a character

        //creating mario STARS
        marioStar = SKSpriteNode(imageNamed: "star.png")
        marioStar.size = CGSize(width: 50, height: 50)
        marioStar.position = CGPoint(x: -130, y: 250)
        
        //creating luigi STARS
        luigiStar = SKSpriteNode(imageNamed: "star.png")
        luigiStar.size = CGSize(width: 50, height: 50)
        luigiStar.position = CGPoint(x: -50, y: 250)
        
        //creating life STARS
        lifeStar = SKSpriteNode(imageNamed: "star.png")
        lifeStar.size = CGSize(width: 50, height: 50)
        lifeStar.position = CGPoint(x: 40, y: 250)
        
        //creating goomba STARS
        goombaStar = SKSpriteNode(imageNamed: "star.png")
        goombaStar.size = CGSize(width: 50, height: 50)
        goombaStar.position = CGPoint(x: 120, y: 250)
        
        
    // Creating the "you win!" image
        //creating the win
        winner = SKSpriteNode(imageNamed: "winner.png")
        winner.size = CGSize(width: 300, height: 200)
        
        
     // Creating the black and white images of the characters to be matched
        
        //bw life
        lifeBW = SKSpriteNode(imageNamed: "lifeBW.png")
        lifeBW.size = CGSize(width: 110, height: 100)
        lifeBW.zPosition = -2
        
        //mw goomba
        goombaBW = SKSpriteNode(imageNamed: "goombaBW.png")
        goombaBW.size = CGSize(width: 100, height: 90)
        goombaBW.zPosition = -2
        
        //bw luigi
        luigiBW = SKSpriteNode(imageNamed: "luigiBW.png")
        luigiBW.size = CGSize(width: 90, height: 150)
        luigiBW.zPosition = -2
        
        //bw mario
        marioBW = SKSpriteNode(imageNamed: "marioBW.png")
        marioBW.size = CGSize(width: 100, height: 160)
        marioBW.zPosition = -2
        
        

        
    //Creating the user moving images of the characters
        
        //mario
        mario = SKSpriteNode(imageNamed: "mario.png")
        mario.size = CGSize(width: 70, height: 130)
        sc.addChild(mario)
        sc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mario.position = CGPoint(x: -130, y: 200)
        mario.physicsBody = SKPhysicsBody(texture: mario.texture ?? SKTexture(imageNamed: "mario.png"), size: mario.frame.size)
        let boundaryM = SKShapeNode(rect: sc.frame)
        boundaryM.physicsBody = SKPhysicsBody(edgeLoopFrom: boundaryM.frame)
        
        boundaryM.position.x = 0
        boundaryM.position.y = 0
        sc.addChild(boundaryM)
        
        
        //luigi
        luigi = SKSpriteNode(imageNamed: "luigi.png")
        luigi.size = CGSize(width: 70, height: 130)
        luigi.position = CGPoint(x: -50, y: 200)
        sc.addChild(luigi)
        sc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        sv.presentScene(sc)
        luigi.physicsBody = SKPhysicsBody(texture: luigi.texture ?? SKTexture(imageNamed: "luigi.png"), size: luigi.frame.size)
        
        let boundary = SKShapeNode(rect: sc.frame)
        boundary.physicsBody = SKPhysicsBody(edgeLoopFrom: boundary.frame)
        
        boundary.position.x = 0
        boundary.position.y = 0
        sc.addChild(boundary)
        
        
        //life
        life = SKSpriteNode(imageNamed: "life.png")
        life.size = CGSize(width: 80, height: 70)
        life.position = CGPoint(x: 40, y: 200)
        sc.addChild(life)
        sc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        life.physicsBody = SKPhysicsBody(texture: life.texture ?? SKTexture(imageNamed: "life.png"), size: life.frame.size)
        let boundaryL = SKShapeNode(rect: sc.frame)
        boundaryL.physicsBody = SKPhysicsBody(edgeLoopFrom: boundaryL.frame)
        
        boundaryL.position.x = 0
        boundaryL.position.y = 0
        sc.addChild(boundaryL)
        
        
        //goomba
        goomba = SKSpriteNode(imageNamed: "goomba.png")
        goomba.size = CGSize(width: 80, height: 70)
        goomba.position = CGPoint(x: 120, y: 200)
        sc.addChild(goomba)
        sc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goomba.physicsBody = SKPhysicsBody(texture: goomba.texture ?? SKTexture(imageNamed: "goomba.png"), size: goomba.frame.size)
        let boundaryG = SKShapeNode(rect: sc.frame)
        boundaryG.physicsBody = SKPhysicsBody(edgeLoopFrom: boundaryG.frame)
        
        boundaryG.position.x = 1
        boundaryG.position.y = 1
        sc.addChild(boundaryG)
        

        //adding black and white mario to start the game
          sc.addChild(marioBW)
        
    }
    
    // the method that takes in the motion of the phone tilt to move the images
    func accelHandler(_ data: CMAccelerometerData?, _ error: Error?) -> Void{
        let dy = data?.acceleration.y
        let dx = data?.acceleration.x
        sc.physicsWorld.gravity = CGVector(dx: dx ?? 0, dy: dy ?? 0)
    }
    
    func block(p: Timer) -> Void {
     
    //checking if the colored user images are being matched with the black and white images
        
        // MARIO
        if ((marioBW.frame.contains(mario.frame)) && sc.children.contains(marioBW)){
            //removing marios
            sc.removeChildren(in: [marioBW!])
            sc.removeChildren(in: [mario!])

            //adding in star
            sc.addChild(marioStar!)
            
            //adding in next black and white image
            sc.addChild(luigiBW!)
        }
        
        if ((luigiBW.frame.contains(luigi.frame)) && sc.children.contains(luigiBW)){
            //removing luigis
            sc.removeChildren(in: [luigiBW!])
            sc.removeChildren(in: [luigi!])
            
            //adding in star
            sc.addChild(luigiStar!)
            
            //adding in next black and white image
            sc.addChild(goombaBW!)
        }
        
        // GOOMBA
        if ((goombaBW.frame.contains(goomba.frame)) && sc.children.contains(goombaBW)){
            //removing goombas
            sc.removeChildren(in: [goombaBW!])
            sc.removeChildren(in: [goomba!])
            
            //adding in the star
            sc.addChild(goombaStar!)
            
            //adding in next black and white image
            sc.addChild(lifeBW!)
        }
        
        // LIFE
        if ((lifeBW.frame.contains(life.frame)) && sc.children.contains(lifeBW)){
            //removing lifes
            sc.removeChildren(in: [lifeBW!])
            sc.removeChildren(in: [life!])
            
            //adding in the star
            sc.addChild(lifeStar!)
            
            //  at this point life is that last character to match,
            //  so once life is matched you win the game!
            //  this is importing the "you win!" image
            sc.addChild(winner!)
        }
    }


}

