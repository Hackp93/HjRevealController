//
//  ViewController.swift
//  HJRevealControllerDemo
//
//  Created by Manu Singh on 07/07/17.
//  Copyright © 2017 Hackj82. All rights reserved.
//

import UIKit
import HJRevealController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.semanticContentAttribute   =   .forceRightToLeft
//        UIApplication.shared.userInterfaceLayoutDirection
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonClick(_ sender: UIButton) {
    
        let drawer  =   HJRevealViewController()
        
        let drawerMenu  =   storyboard?.instantiateViewController(withIdentifier: "drawer")
        let mainVC  =   storyboard?.instantiateViewController(withIdentifier: "mainvc")
        
        drawer.drawerWidth          =   0.7
        drawer.mainViewController   =   mainVC
        drawer.drawerViewController =   drawerMenu
        
        
        
        present(drawer, animated: true, completion: nil)
        
    }

}

