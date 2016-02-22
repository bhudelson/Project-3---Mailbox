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
    var messageInitialCenter: CGPoint!
    var swipedRightPosition: CGFloat!
    var snappedBackPosition: CGFloat!
    var swipedLeftPosition: CGFloat!
    
    
    var mainViewInitialCenter: CGPoint!
    var mainViewOriginalPosition: CGFloat!
    var mainViewSwipedRightPosition: CGFloat!
    var mainViewStartRightPositionX: CGFloat!
    var mainViewStartRightPosition: CGPoint!
    
    
    var feedWrapperViewInitialY: CGFloat!
    var feedWrapperViewOffset: CGFloat!
    
    var mainViewSwiped: Bool!
    var messageSnoozed: Bool!
    var messageArchived: Bool!
    var messageDeleted: Bool!
    var messageMoved: Bool!
    
    
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1350)
        
        
        snappedBackPosition = message.center.x
        swipedRightPosition = message.center.x + 320
        swipedLeftPosition = message.center.x - 320
        
        rescheduleView.alpha = 0
        listView.alpha = 0
        
        feedWrapperViewInitialY = feedWrapperView.frame.origin.y
        feedWrapperViewOffset = -86
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        mainView.addGestureRecognizer(edgeGesture)
        
        mainViewOriginalPosition = mainView.center.x
        mainViewSwipedRightPosition = mainView.center.x + 280
        mainViewStartRightPositionX = mainView.center.x + 280

        mainViewSwiped = false
        messageSnoozed = false
        messageMoved = false
        messageDeleted = false
        messageArchived = false
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Edge pan main view
    
    @IBAction func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            mainViewInitialCenter = mainView.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            mainView.center = CGPoint(x: translation.x + mainViewInitialCenter.x, y: mainViewInitialCenter.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if velocity.x > 0 {
                    self.mainView.center.x = self.mainViewSwipedRightPosition
                } else if velocity.x < 0 {
                    self.mainView.center.x = self.mainViewOriginalPosition
                }
            })
        }

    }
    

    
    //Pan Functions
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
//        var velocity = sender.velocityInView(view)
        
        //Pan Began
        if sender.state == UIGestureRecognizerState.Began {
            messageInitialCenter = message.center
            
        }
         
            
        //Pan Changed
        else if sender.state == UIGestureRecognizerState.Changed {
            message.center = CGPoint(x: translation.x + messageInitialCenter.x, y: messageInitialCenter.y)
            
            //Alpha Conversions
            let leftIconViewConvertedAlpha = convertValue(translation.x, r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
            leftIconView.alpha = CGFloat(leftIconViewConvertedAlpha)
            let rightIconConvertedAlpha = convertValue(translation.x, r1Min: 0, r1Max: -60, r2Min: 0, r2Max: 1)
            rightIconView.alpha = CGFloat(rightIconConvertedAlpha)
            
            //Translation Conversions
            let leftIconViewConvertedTranslation = convertValue(translation.x, r1Min: 60, r1Max: 320, r2Min: 0, r2Max: 260)
            let rightIconViewConvertedTranslation = convertValue(translation.x, r1Min: -60, r1Max: -320, r2Min: 0, r2Max: -260)
            
            
            //Pan to right, gray bg
            if translation.x >= 0 && translation.x < 60 {
                messageBgView.backgroundColor = UIColor (red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
                archiveIconView.hidden = false
                deleteIconView.hidden = true
                listIconView.hidden = true
                laterIconView.hidden = true
        
            }
            
            //Pan to right, green bg
            else if translation.x >= 60 && translation.x < 260 {
                messageBgView.backgroundColor = UIColor(red: 151/255, green: 242/255, blue: 61/255, alpha: 1.0)
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
            else if translation.x <= 0 && translation.x > -60 {
                messageBgView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = true
                self.listIconView.hidden = true
                self.laterIconView.hidden = false
            }
                
            //Pan to left, yellow bg
            else if translation.x <= -60 && translation.x > -260 {
                messageBgView.backgroundColor = UIColor(red: 253/255, green: 237/255, blue: 33/255, alpha: 1.0)
                rightIconView.transform = CGAffineTransformMakeTranslation(rightIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = true
                self.listIconView.hidden = true
                self.laterIconView.hidden = false
            }
                
                
        //Pan to left, brown bg
        else if translation.x <= -260 {
                messageBgView.backgroundColor = UIColor(red: 162/255, green: 151/255, blue: 128/255, alpha: 1.0)
                rightIconView.transform = CGAffineTransformMakeTranslation(rightIconViewConvertedTranslation, 0)
                self.archiveIconView.hidden = true
                self.deleteIconView.hidden = true
                self.listIconView.hidden = false
                self.laterIconView.hidden = true
            }
        }
            
        //Pan Ended
        else if sender.state == UIGestureRecognizerState.Ended {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    
                //Pan to right, finish swipe, archive message
                if translation.x >= 60 && translation.x < 260 {
                self.message.center.x = self.swipedRightPosition
//                self.messageArchived = true
                    
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.archiveIconView.alpha = 0
                }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.feedWrapperView.frame.origin.y = self.feedWrapperViewInitialY + self.feedWrapperViewOffset
                    })
                }
            }
                    
                    
                //Pan to right, finish pan, delete message
                else if translation.x >= 260 {
                self.message.center.x = self.swipedRightPosition
//                self.messageDeleted = true
                    
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.deleteIconView.alpha = 0
                }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.feedWrapperView.frame.origin.y = self.feedWrapperViewInitialY + self.feedWrapperViewOffset
                            })
                    }
                }
                    
                //Pan to left, finish pan, show reschedule view
                else if translation.x <= -60 && translation.x > -260 {
                self.message.center.x = self.swipedLeftPosition
//                self.messageSnoozed = true
            
                        
                UIView.animateWithDuration(0.1, animations:  { () -> Void in
                self.laterIconView.alpha = 0
                })
                        
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.rescheduleView.alpha = 1
                        })
                        
                }
                
                //Pan to left, finish swipe, show LO
                else if translation.x <= -260 {
                    self.message.center.x = self.swipedLeftPosition
//                    self.messageMoved = true
                    
                    UIView.animateWithDuration(0.1, animations:  { () -> Void in
                        self.listIconView.alpha = 0
                    })
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.listView.alpha = 1
                    })
                    
                }
                    
                //Pan in each direction, snap to center
                else {
                    self.message.center.x = self.snappedBackPosition

                    
                    }
                        
                
                })
                
            }
            
            
        
            }
    
    //Segmented control
    @IBAction func didToggleNav(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.scrollView.frame.origin.x = 0
            })
        case 1:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.scrollView.frame.origin.x = -320
            })
        case 2:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.scrollView.frame.origin.x = -640
            })
        default:
            break;
        }
    }
    
        

    
    //Closing the menu view
    
    
    //Dismissing the Reschedule View
    @IBAction func didTapRescheduleView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations:  { () -> Void in
            self.rescheduleView.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedWrapperView.frame.origin.y = self.feedWrapperViewInitialY + self.feedWrapperViewOffset
                })
    }
    }
    
    //Dismissing the List View
    @IBAction func didTapListViewTest(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations:  { () -> Void in
            self.listView.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedWrapperView.frame.origin.y = self.feedWrapperViewInitialY + self.feedWrapperViewOffset
                })
        }
    }
    }
