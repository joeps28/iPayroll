//
//  ViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/11/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SideBarDelegate, UIGestureRecognizerDelegate {
    
    let stackControllers = ["Year Summary", "Last Month", "This Month"]
    let stackOffset: CGFloat = 250
    let stackElementHeight: CGFloat = 50
    let stackElementHeightForShow: CGFloat = 85
    
    var viewPinned: UIView? = nil
    var lastViewIndex: Int? = nil
    
    var sideBar:SideBar = SideBar()
    
    var controllerViews = [UIView]()
    
    @IBOutlet weak var addButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleTap(gesture:)))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        var offset: CGFloat = stackOffset
        
        for i in 0 ... stackControllers.count - 1 {
            if let view = addViewController(atOffset: offset, dataForVC: stackControllers[i] as AnyObject?) {
                controllerViews.append(view)
                offset -= stackElementHeight
            }
            
        }
    
        sideBar = SideBar(sourceView: self.view, menuItems: ["History", "Profile", "About"])
        sideBar.delegate = self

    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        
        if let view = viewPinned {
            dismissView(view: view)
        }
        else {
            let touchPoint = gesture.location(ofTouch: 0, in: self.view)
            let height = self.view.frame.height
        
            if touchPoint.y > (height - stackOffset) && touchPoint.y < (height - stackOffset + stackElementHeight) {
                showView(view: controllerViews[0])
                lastViewIndex = 0
            }
            else if touchPoint.y > (height - stackOffset + stackElementHeight) && touchPoint.y < (height - stackOffset + 2 * stackElementHeight) {
                showView(view: controllerViews[1])
                lastViewIndex = 1
            }
            else if touchPoint.y > (height - stackOffset + 2 * stackElementHeight) && touchPoint.y < (height - stackOffset + 3 * stackElementHeight) {
                showView(view: controllerViews[2])
                lastViewIndex = 2
            }
            else {
                self.resignFirstResponder()
            }
        }
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideBar.sideBarTableViewController.tableView))! {
            return false
        }
        
        return true
    }
    
    func showView(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.setVisibility(view: view, alpha: 0)
            
            view.frame = CGRect(x: 0, y: self.stackElementHeightForShow, width: view.frame.width, height: view.frame.height)
            
        }) { (Completed: Bool) in
            
            self.viewPinned = view
        }
    }
    
    func dismissView(view: UIView) {
        
        var newFrame: CGRect? = CGRect()
        let height = self.view.frame.height
        
        if lastViewIndex == 0 {
            newFrame = CGRect(x: 0, y: (height - stackOffset), width: view.frame.width, height: view.frame.height)
        }
        else if lastViewIndex == 1 {
            newFrame = CGRect(x: 0, y: (height - stackOffset + stackElementHeight), width: view.frame.width, height: view.frame.height)
        }
        else if lastViewIndex == 2 {
            newFrame = CGRect(x: 0, y: (height - stackOffset + 2 * stackElementHeight), width: view.frame.width, height: view.frame.height)
        }
        
        if let frame = newFrame {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.setVisibility(view: view, alpha: 1)
                
                view.frame = frame
            }) { (Completed: Bool) in
                
                self.viewPinned = nil
            }
        }
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if index == 0 {
//            let vc = sb.instantiateViewController(withIdentifier: "HistoryVC")
//            
//            self.present(vc, animated: true, completion: nil)
        }
        else if index == 1 {
            let vc = sb.instantiateViewController(withIdentifier: "ProfileVC")
            
            self.present(vc, animated: true, completion: nil)
        }
        else if index == 2 {
//            let vc = sb.instantiateViewController(withIdentifier: "AboutVC")
//
//            self.present(vc, animated: true, completion: nil)
        }
    }
        
        
    func addViewController(atOffset offset: CGFloat, dataForVC data: AnyObject?) -> UIView? {
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let stackElementVC = sb.instantiateViewController(withIdentifier: "StackElement") as! StackElementViewController
        
        if let view = stackElementVC.view {
            view.frame = frameForView
            view.layer.cornerRadius = 5
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowRadius = 3
            view.layer.shadowOpacity = 0.5
            
            
            /* Setup the data for view */
            if let headingStr = data as? String {
                stackElementVC.headerString = headingStr
            }
            
            self.addChildViewController(stackElementVC)
            self.view.addSubview(view)
            stackElementVC.didMove(toParentViewController: self)
            
            return view
        }
        
        return nil
    }
    
    func setVisibility(view: UIView, alpha: CGFloat) {
        for aView in controllerViews {
            if aView != view {
                aView.alpha = alpha
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
    }

}

