//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Blake Hudelson on 2/18/16.
//  Copyright © 2016 Blake Hudelson. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var message: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var rightBgView: UIImageView!
    @IBOutlet weak var leftBgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var hamburgerButton: UIButton!
    
    var messageOriginalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    var scrollViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laterIconView.alpha = 0.5
        rescheduleView.alpha = 0
        
    
        
//        messageOriginalCenter = 0
        messageLeft = message.center
//        messageRight = CGPoint(x: message.center.x ,y: message.center.y + messageOriginalCenter)

        scrollView.contentSize = CGSize(width: 320, height: 1350)
       
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
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let messageVelocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        messageOriginalCenter = message.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            message.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            laterIconView.alpha = 1
        
        } else if sender.state == UIGestureRecognizerState.Ended {
            
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



