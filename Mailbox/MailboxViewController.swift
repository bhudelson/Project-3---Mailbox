//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Blake Hudelson on 2/18/16.
//  Copyright © 2016 Blake Hudelson. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    //Outlets
    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet weak var message: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var feedWrapperView: UIView!
    @IBOutlet weak var messageBgView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var rightIconView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    

    //Variables
    var messageOriginalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    var scrollViewOriginalCenter: CGPoint!
    
    var mainViewInitialCenter: CGPoint!
    var mainViewOriginalPosition: CGFloat!
    var mainViewSwipedRightPosition: CGFloat!
    var mainViewStartRightPositionX: CGFloat!
    var mainViewStartRightPosition: CGPoint!
    
    
    
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1350)
        
        rescheduleView.alpha = 0
        listView.alpha = 0
        
        
        messageLeft = message.center

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didEdgePanFeed(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let scrollViewVelocity = sender.velocityInView(view)
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        scrollView.addGestureRecognizer(edgeGesture)
        
        if sender.state == UIGestureRecognizerState.Began {
            scrollViewOriginalCenter = scrollView.center
            
            
        }
    }
    
    //Pan Functions
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let messageVelocity = sender.velocityInView(view)
        
        
        //Pan Started
        if sender.state == UIGestureRecognizerState.Began {
            
        messageOriginalCenter = message.center
            
        }
         
            
        //Pan Changed
        else if sender.state == UIGestureRecognizerState.Changed {
            message.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            laterIconView.alpha = 1
        
            }
            
            
        //Pan Ended
        else if sender.state == UIGestureRecognizerState.Ended {
            
            if messageVelocity.y > 0 {
                //UIView.animateWithDuration(0.3, animations: { () -> Void in self.trayView.center = self.trayDown
                //UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: <#T##UIViewAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
                
                //})
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in self.laterIconView.frame.origin.x = -10
                })
                
            } else {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in self.message.center = self.messageLeft
                    
                    
                })
                
            }
            
            
            }
                
            }
            
        }



