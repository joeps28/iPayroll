//
//  MenuLauncher.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/11/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class MenuLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    //let menuBarWidth: CGFloat = 180
    let menuBarHeight: CGFloat = 200
    
    let cellID = "cellID"
    
    let settings: [MenuItem] = {
        return [MenuItem(name: "History", imageName: "find-folder-22"), MenuItem(name: "Profile Settings", imageName: "boy-22"), MenuItem(name: "About", imageName: "About"), MenuItem(name: "Cancel", imageName: "Cancel-icon")]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.regular))
        cv.backgroundColor = UIColor.clear
        
        blurView.frame = cv.frame
        //cv.backgroundView = blurView
        
        return cv
    }()
    
    var homeController: MainViewController?
    
    func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.menuBarHeight)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height - self.menuBarHeight, width: window.frame.width, height: self.menuBarHeight)
            }, completion: nil)
            
            
        }
    }
    
    func handleDismiss(setting: MenuItem) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.menuBarHeight)
            }
            
        }) { (Completed: Bool) in
            
            if let hc = self.homeController {
                if setting.name != "" && setting.name != "Cancel" {
                    hc.showControllerForSetting(setting: setting)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.frame = cell.frame
        cell.backgroundView = blurView
        
        let setting = settings[indexPath.row]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
        
    }
    
    override init() {
        super.init()
        
        homeController = nil
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
    }
}





























