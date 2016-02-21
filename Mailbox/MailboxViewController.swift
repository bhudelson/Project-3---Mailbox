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
    
    var swipedRightPosition: CGFloat!
    var swipedLeftPosition: CGFloat!
    var snappedBackPosition: CGFloat!
    
    var feedWrapperViewInitialY: CGFloat!
    var feedWrapperViewOffset: CGFloat!
    
    
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1350)
        
        snappedBackPosition = message.center.x
        swipedRightPosition = message.center.x + 320
        swipedLeftPosition = message.center.x - 320
        
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
            
            //Alpha Conversions
            let leftIconViewConvertedAlpha = convertValue(translation.x, r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
            leftIconView.alpha = CGFloat(leftIconViewConvertedAlpha)
            let rightIconConvertedAlpha = convertValue(translation.x, r1Min: -60, r1Max: -320, r2Min: 0, r2Max: -260)
            rightIconView.alpha = CGFloat(rightIconConvertedAlpha)
            
            //Translation Conversions
            let leftIconViewConvertedTranslation = convertValue(translation.x, r1Min: 60, r1Max: 320, r2Min: 0, r2Max: 260)
            let rightIconViewConvertedTranslation = convertValue(translation.x, r1Min: -60, r1Max: -320, r2Min: 0, r2Max: -260)
            
            
            //Pan to right, gray bg
            if translation.x >= 0 && translation.x < 60 { messageBgView.backgroundColor = UIColor (red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
                archiveIconView.hidden = false
                deleteIconView.hidden = true
                listIconView.hidden = true
                laterIconView.hidden = true
        
            }
            
            //Pan to right, green bg
            else if translation.x >= 60 && translation.x < 260 { messageBgView.backgroundColor = UIColor(red: 151/255, green: 242/255, blue: 61/255, alpha: 1.0)
                self.leftIconView.transform = CGAffineTransformMakeTranslation(leftIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = false
                self.deleteIconView.hidden = true
                self.listIconView.hidden = true
                self.laterIconView.hidden = true
            }
            
            //Pan to right, red bg
            else if translation.x >= 260 {
                messageBgView.backgroundColor = UIColor(red: 250/255, green: 77/255, blue: 67/255, alpha: 1.0)
                leftIconView.transform = CGAffineTransformMakeTranslation(leftIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = false
                self.listIconView.hidden = true
                self.laterIconView.hidden = true
            }
                
            //Pan to left, gray bg
            else if translation.x >= 0 && translation.x < -60 {
                messageBgView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = false
                self.listIconView.hidden = true
                self.laterIconView.hidden = true
            }
                
            //Pan to left, blue bg
            else if translation.x <= -60 && translation.x > -260 {
                messageBgView.backgroundColor = UIColor(red: 42/255, green: 150/255, blue: 250/255, alpha: 1.0)
                rightIconView.transform = CGAffineTransformMakeTranslation(rightIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = true
                self.listIconView.hidden = true
                self.laterIconView.hidden = false
            }
                
                
        //Pan to left, dark gray bg
        else if translation.x <= -260 {
                messageBgView.backgroundColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
                rightIconView.transform = CGAffineTransformMakeTranslation(rightIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = true
                self.listIconView.hidden = false
                self.laterIconView.hidden = true
            }
                
        //Pan Ended
        else if sender.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
            
                if translation.x >= 60 && translation.x < 260 {
                self.message.center.x = self.swipedRightPosition
                        
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.archiveIconView.alpha = 0
                }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.feedWrapperView.frame.origin.y = self.feedWrapperViewInitialY + self.feedWrapperViewOffset
                    })
                }
            }
                    
                    
        //Pan to left, finish swipe, show reschedule view
        else if translation.x <= -60 && translation.x > -260 {
                self.message.center.x = self.swipedLeftPosition
            
                        
                UIView.animateWithDuration(0.1, animations:  { () -> Void in
                self.laterIconView.alpha = 0
                })
                        
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.rescheduleView.alpha = 1
                        })
                        
                }
                    
                    
                    
            if messageVelocity.y > 0 {
               
                    }
                
                })
                
            } else {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in self.message.center = self.messageLeft
                    
                    
                })
                
            }
            
            
            }
                
            }
            
        }



