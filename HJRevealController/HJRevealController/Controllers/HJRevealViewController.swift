//
//  HJRevealControllerViewController.swift
//  HJRevealController
//
//  Created by Manu Singh on 10/07/17.
//
//

import UIKit

public class HJRevealViewController: UIViewController {

    // MARK: - public properties
    
    
    ///Width of the drawer as percentage width of screen width, value of 1 means full width, value of 0 means drawer width 0
    public var drawerWidth : CGFloat = 0.8
    
    
    public var shadowColor : UIColor = UIColor.black {
        didSet{
            addShadow()
        }
    }
    
    public var shadowOpacity : Float = 0.5 {
        didSet{
            addShadow()
        }
    }
    
    public var shadowOffset : CGSize = CGSize(width: -2, height: 0) {
        didSet{
            addShadow()
        }
    }
    
    public var mainViewController : UIViewController? = nil {
        didSet{
            if mainViewController != nil {
                setMainViewController()
            }
        }
    }
    
    
    public var drawerViewController : UIViewController? = nil {
        didSet{
            if drawerViewController != nil {
                setDrawerViewController()
            }
        }
    }
    
    public var drawerState : DrawerState  = .Closed
    
    public var drawerType : DrawerType  =   .Drawer
    
    // MARK: - private properties
    
    var closeButton : UIButton!
    
    var gesture : UIPanGestureRecognizer!
    var gestureStartingPoint : CGPoint!
    
    
    var mainControllerIdentifier : String!
    var drawerControllerIdentifier : String!
    
    // MARK: - overridden methods
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if mainControllerIdentifier != nil {
            mainViewController  =   storyboard?.instantiateViewController(withIdentifier: mainControllerIdentifier)
        }
        
        if drawerControllerIdentifier != nil {
            drawerViewController  =   storyboard?.instantiateViewController(withIdentifier: drawerControllerIdentifier)
        }
        
        view.backgroundColor    =   UIColor.white
        gesture     =   UIPanGestureRecognizer(target: self, action: #selector(openDrawerDragging))
        gesture.delaysTouchesEnded  =   true
        view.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
        
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addShadow()
        
    }
    
    
    public func enableDrawer(){
        gesture.isEnabled   =   true
    
    }
    
    public func disableDrawer(){
        gesture.isEnabled   =   false
        
    }

    
    func openDrawerDragging(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        
        if sender.state == UIGestureRecognizerState.began {
            
            if sender.location(in: self.view).x <= 15 || drawerState == .Open {
                gestureStartingPoint    =   translation
            }
            
            
        } else if sender.state == UIGestureRecognizerState.ended {

                if gestureStartingPoint != nil {
                    let velocity = sender.velocity(in: self.view)
                    gestureStartingPoint = nil
                    if velocity.x >= 0 {
                        drawerState = .Closed
                        self.openDrawer(velocity: velocity.x)
                    } else {
                        drawerState = .Open
                        self.closeDrawer(velocity: velocity.x)
                    }
                }
            
            
        } else if sender.state == UIGestureRecognizerState.changed {
            
                if gestureStartingPoint != nil {
                    
                        mainViewController?.view.center.x   =       (mainViewController?.view.center.x)! +  translation.x
                        sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                        
                        if (mainViewController?.view.frame.minX)! >= (drawerViewController?.view.frame.maxX)! {
                            mainViewController?.view.center.x   =    ((drawerViewController?.view.frame.maxX)! +  ((mainViewController?.view.frame.width)!*0.5))
                            drawerState                         =   .Open
                        }
                        if (mainViewController?.view.frame.minX)! <= 0 {
                            mainViewController?.view.center.x   =   (mainViewController?.view.frame.width)!*0.5
                            drawerState                         =   .Closed
                        }
                    
                }

        } else {
            
            
        }
        
    }

    
    
    func setMainViewController(){
        
        addChildViewController(mainViewController!)
        self.view.addSubview((mainViewController?.view)!)
        mainViewController?.didMove(toParentViewController: self)
        
        mainViewController?.view.translatesAutoresizingMaskIntoConstraints   =   false
        
        NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: mainViewController?.view, attribute: .centerX, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: mainViewController?.view, attribute: .centerY, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: mainViewController?.view, attribute: .height, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: mainViewController?.view, attribute: .width, multiplier: 1, constant: 0).isActive   =   true
    }

    
    func setDrawerViewController(){
     
        addChildViewController(drawerViewController!)
        self.view.addSubview((drawerViewController?.view)!)
        drawerViewController?.didMove(toParentViewController: self)
        
        drawerViewController?.view.translatesAutoresizingMaskIntoConstraints   =   false
        
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: drawerViewController?.view, attribute: .leading, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: drawerViewController?.view, attribute: .centerY, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: drawerViewController?.view, attribute: .height, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: drawerViewController!.view!, attribute: .width, relatedBy: .equal, toItem:view , attribute: .width, multiplier: drawerWidth, constant: 0).isActive   =   true

        view.bringSubview(toFront:  (mainViewController?.view)!)
        setButton()
    }
    
    
    func setButton(){
        
        if closeButton == nil {
        closeButton    =   UIButton()
        closeButton.isHidden    =   true
        closeButton.translatesAutoresizingMaskIntoConstraints   =   false
        closeButton.addTarget(self, action: #selector(onClickCloseButton), for: .touchUpInside)
        
        closeButton.backgroundColor  =   UIColor.clear
        view.addSubview(closeButton)
        
        NSLayoutConstraint(item: drawerViewController!.view!, attribute: .trailing, relatedBy: .equal, toItem: closeButton, attribute: .leading, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: closeButton, attribute: .height, multiplier: 1, constant: 0).isActive   =   true
        
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem:view , attribute: .width, multiplier: (1 - drawerWidth), constant: 0).isActive   =   true
        view.bringSubview(toFront: closeButton)
        }
    }
    
    func onClickCloseButton(_ sender : UIButton){
        closeDrawer()
    }
    
    
    public func openDrawer(velocity : CGFloat = 0){
        
        guard gesture.isEnabled else {
            return
        }
        
        if closeButton != nil {
            closeButton.isHidden     =   false
        }
            drawerState =   .Open
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.mainViewController?.view?.center.x  = ((self.drawerViewController?.view.frame.maxX)! + ((self.mainViewController?.view.frame.width)!*0.5))
        }, completion: nil)
        
    }
    
    public func closeDrawer(velocity : CGFloat = 0){
        
        guard gesture.isEnabled else {
            return
        }
        
        if closeButton != nil {
            closeButton.isHidden        =   true
        }
            drawerState =   .Closed
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
        
            self.mainViewController?.view?.center.x  = ((self.mainViewController?.view.frame.width)!*0.5)
        }, completion: nil)
        
        
    }
    
    
    func addShadow(){
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {
                timer in
                
                
                self.mainViewController?.view.layer.shadowColor     =   self.shadowColor.cgColor
                self.mainViewController?.view.layer.shadowOffset    =   self.shadowOffset
                self.mainViewController?.view.layer.shadowOpacity   =   self.shadowOpacity
                self.mainViewController?.view.layer.shadowPath      =   UIBezierPath(roundedRect: (self.mainViewController?.view.bounds)!, cornerRadius: 0).cgPath
                
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



public enum DrawerState : String {
    case Open
    case Closed
    
}

public enum DrawerType : String {
    case Reveal
    case Drawer
}
