//
//  ViewController.swift
//  Gesture
//
//  Created by Hendy Sen on 03/07/19.
//  Copyright © 2019 Hendy Sen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var longPressView: UIView!
    @IBOutlet weak var rocketImg: UIImageView!
    
    @IBOutlet weak var tapImageView: UIImageView!
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var pinchView: UIView!
    @IBOutlet weak var swipeView: UIView!
    var spin = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Tap Gesture
        tapImageView.isUserInteractionEnabled = true
        tapImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        //Long press gesture
        longPressView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongpress)))
        
        //Swipe Gesture
        swipeView.layer.cornerRadius = swipeView.frame.height/2
        let swipeDirection: [UISwipeGestureRecognizer.Direction] = [.right, .left, .down, .up]
        for directions in swipeDirection {
            let swiped = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            swiped.direction = directions //ganti direction atau kasih variable lagi kalo mau arah lain
             self.swipeView.addGestureRecognizer(swiped)
        }
        
       
//        swipeView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeUp)))
        // pinch Gesture
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView))
        self.pinchView.addGestureRecognizer(pinch)
        panView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pannedView)))
        
        pinchView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotatedView)))
    }
    //tap func
    @objc func handleTap(gesture : UITapGestureRecognizer){
        view.backgroundColor = .purple
        tapImageView.image = UIImage(named: "surprised.jpg")
    }
    
    //longpress func
    @objc func handleLongpress(){
        self.view.backgroundColor = .yellow
        let image = UIImage(named: "Long Press 2.png")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: longPressView.frame.minX, y: longPressView.frame.minY, width: longPressView.frame.width, height: longPressView.frame.height)
        view.addSubview(imageView)
    }
    // swipe func
    @objc func swipe(gesture : UISwipeGestureRecognizer){
       
        print(gesture.direction)
        if gesture.direction == .up {
            self.view.backgroundColor = .red
            let image = UIImage(named: "Swipe 2.png")
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: swipeView.frame.minX, y: swipeView.frame.minY, width: swipeView.frame.width, height: swipeView.frame.height)
            view.addSubview(imageView)
            
        }
        else if gesture.direction == .down {
            self.view.backgroundColor = .brown
        }
    }
    //pinch func
    @objc func pinchedView(gesture : UIPinchGestureRecognizer){
        print(gesture.velocity)
        print("aaaaaaaaaaa", gesture.scale)
    
        pinchView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
        print(pinchView.transform)
        
        if gesture.state == .ended {
//            pinchView.transform = CGAffineTransform(scaleX: 1, y: 1)    
        }
        else if gesture.state == .began {
            pinchView.backgroundColor = .black
        }
    }
    //pan / drag func
    @objc func pannedView(gesture : UIPanGestureRecognizer){
        
      panView.center = CGPoint(x: panView.center.x + gesture.translation(in: view).x, y: panView.center.y + gesture.translation(in: view).y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    // rotated func
    @objc func rotatedView(gesture : UIRotationGestureRecognizer){
        pinchView.transform = pinchView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
}

