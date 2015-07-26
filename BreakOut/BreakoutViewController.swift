//
//  BreakoutViewController.swift
//  BreakOut
//
//  Created by Kevin Suh on 7/3/15.
//  Copyright (c) 2015 Stanford Class. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController {

    @IBOutlet weak var gameView: GameView!  
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    struct Brick {
        static let MarginX: CGFloat = 5.0
        static let MarginY: CGFloat = 5.0
    }
    
    var animator: UIDynamicAnimator?
    var bricksPerRow = 6
    var numberOfRows = 4
    var gameViewWidth: CGFloat {
        return view.bounds.width
    }
    var brickSize: CGSize? {
        // this should always return true
        var totalBrickWidth = Double(gameViewWidth) - ((Double(Brick.MarginX) * Double(bricksPerRow + 1)))
        var brickWidth = totalBrickWidth / Double(bricksPerRow)
        var brickHeight = 10 // maybe this can be configurable in the future
        return CGSize(width: CGFloat(brickWidth), height: CGFloat(brickHeight))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // once paddle/balls load, let's add all of the animator stuff. this should be done via lazy instantiation, since the animator needs to access the UI elements
        
    }
    
    // handle resizing of game on landscape
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            println("landscape")
        } else {
            println("portraight")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // set up all of the UI tools before app laods
        // 1. bricks
        // 2. ball
        // 3. paddle
        
        buildBricks()
        
    }
    
    func buildBricks() {
        // build bricks as UIViews given the bricks per row
        // this is not best design, but it's safe
        var brick: CGRect
        if let brickSize = self.brickSize {
            brick = CGRect(origin: CGPoint(x: 0, y: Brick.MarginY), size: brickSize)
            
            for _ in 1...numberOfRows {
                for _ in 1...bricksPerRow {
                    
                    // handle left margin
                    brick.origin.x += Brick.MarginX
                    
                    let brickView = UIView(frame: brick)
                    brickView.backgroundColor = UIColor.redColor()
                    gameView.addSubview(brickView)
                    brick.origin.x += brickSize.width
                    
                    // handle right margin
                    //brick.origin.x += Brick.MarginX
                    
                }
                brick.origin.y += (brickSize.height + Brick.MarginY)
                brick.origin.x = 0
            }
            var gameViewWidth = gameView.bounds.width
            gameViewWidth = view.bounds.width
            var testFrame = CGRect(origin: CGPoint(x: 0, y: 150), size: CGSize(width: gameViewWidth, height: 50))
            let testView = UIView(frame: testFrame)
            testView.backgroundColor = UIColor.purpleColor()
            gameView.addSubview(testView)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
