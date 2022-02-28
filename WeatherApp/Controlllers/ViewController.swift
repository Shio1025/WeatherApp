//
//  ViewController.swift
//  WeatherApp
//
//  Created by shio birbichadze on 1/23/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var label:UILabel!
    @IBOutlet var button:UIButton!
    @IBOutlet var l:UILabel!
    
    let emitter = SKEmitterNode(fileNamed: "Rain.sks")!
    
    var player1:AVAudioPlayer?
    var player2:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        setBackground()
        rain()
        playSound1()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
//    private func deleteBacgroundAndRain(){
//        for subview in self.view.subviews{
//            if subview is UIImageView{
//                subview.removeFromSuperview()
//                print("hi1")
//            }
//
//            if subview is SKView{
//                subview.removeFromSuperview()
//                print("hi2")
//            }
//        }
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        if UIDevice.current.orientation.isLandscape {
//            print("Landscape")
//
//
//            self.deleteBacgroundAndRain()
//            self.setBackground()
//            self.rain()
//
//        }else{
//            self.deleteBacgroundAndRain()
//            self.setBackground()
//            self.rain()
//
//        }
//
//    }
    
    func setBackground(){
        let background = UIImage(named: "storm2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
//        view.addSubview(imageView)
//        self.view.sendSubviewToBack(imageView)
        view.insertSubview(imageView, at: 0)
        
    }
    
    @IBAction func start(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "TabBarController")
        navigationController?.setViewControllers([vc!], animated: true)

    }
    
    func goToErrorPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "startPageError")
        navigationController?.setViewControllers([vc!], animated: true)
    }
    
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.l.alpha=0.0
        self.label.alpha=0.0
        self.button.alpha=0.0
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear], animations: {
            
            self.label.alpha=1.0
            
            self.view.layoutIfNeeded()
        }, completion: {_ in
            UIView.animate(withDuration: 8, delay: 0, options: [.curveLinear], animations: {
                self.button.alpha=1.0
                
                self.view.layoutIfNeeded()
            }, completion:nil)
        })
        
        animate()
        
        
    }
    
    func animate(){
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0,
            options: [.calculationModeLinear,.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.5,
                    animations: {
                        self.l.alpha=1
                }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.5,
                    animations: {
                        self.l.alpha=0
                }
                )
        },
            completion: nil
        )
        
      
    }
    
    
    
    func rain(){
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .clear
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .clear
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitter)
        emitter.position.y = scene.frame.maxY
        emitter.particlePositionRange.dx = scene.frame.width
        view.insertSubview(skView, at: 1)
        
    }
    
    func playSound1() {

        let path = Bundle.main.path(forResource: "rain", ofType: "mp3")!
        let url=URL(fileURLWithPath: path)
        do {
            player1 = try AVAudioPlayer(contentsOf: url)

            player1?.numberOfLoops = -1
            
            player1?.play()

        } catch  {
            goToErrorPage()
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
        super.touchesEnded(touches, with: event)
        let touch = touches.first
        let location = touch?.location(in: view)
        let xCoordinate=CGFloat.random(in: self.view.frame.size.width/4...3*self.view.frame.size.width/4)
        lightning(x:location?.x ?? xCoordinate)
        playSound2()
    }
        
    func playSound2() {
        
        
        
        let path = Bundle.main.path(forResource: "thunder", ofType: "mp3")!
        let url=URL(fileURLWithPath: path)
        do {
            player2 = try AVAudioPlayer(contentsOf: url)
            
           
            
            player2?.play()
            
        } catch  {
            goToErrorPage()
        }
    }
    
    
    
    
    
    
    
    
    func lightning(x:CGFloat){
        
            let path = self.genrateLightningPath(startingFrom: CGPoint(x: x, y:0),angle:0,branch:false)
            self.lightningStrike(throughPath: path)
        
        
    }
    
    
    func createLine(start: CGPoint, end: CGPoint) ->CALayer {
        let line = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        line.path = path.cgPath
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = 1
        line.lineJoin = CAShapeLayerLineJoin.round
        
        line.shadowRadius=10
        line.shadowColor = UIColor.white.cgColor
        line.shadowOpacity=0.8
        
        
        return line
    }

    
    func genrateLightningPath(startingFrom: CGPoint, angle:CGFloat, branch:Bool) -> [CALayer] {
        var strikePath: [CALayer] = []
        var startPoint = startingFrom
        var endPoint = startPoint
        let numberOfLines = branch ? 80 : 150
        
        var i = 0
        while i < numberOfLines {
            strikePath.append(createLine(start: startPoint, end: endPoint))
            startPoint = endPoint
            let r = CGFloat(self.view.frame.height/60)
            endPoint.y += r*cos(angle) + CGFloat.random(in: -r ... r)
            endPoint.x +=  r*sin(angle) + CGFloat.random(in: -r ... r)
            if Int.random(in: 0 ... 80) == 1 {
                let branchPoint = endPoint
                
                let branchAngle = CGFloat.random(in: -CGFloat.pi / 4 ... CGFloat.pi / 4)
                
                strikePath.append(contentsOf:genrateLightningPath(startingFrom: branchPoint, angle: branchAngle, branch: true))
            }
            i += 1
        }
        return strikePath
    }
    
    
    func lightningStrike(throughPath: [CALayer]) {
//        for _ in 1...Int.random(in: 4 ... 6){
            let time=CFTimeInterval(CGFloat.random(in: 0.8 ... 1.5))
            let count=Int.random(in: 2 ... 4)
            for line in throughPath {
            
                
                self.view.layer.insertSublayer(line, at: 1)
                let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
                animation.fromValue = 1
                animation.toValue = 0
                animation.duration = time
                animation.repeatCount=Float(count)
                
                animation.fillMode = CAMediaTimingFillMode.forwards;
                animation.isRemovedOnCompletion = false;
            
            
//                CATransaction.begin()
                line.add(animation, forKey: #keyPath(CALayer.opacity))
                
               
            
            
            }
        
        

}



}



