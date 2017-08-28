//
//  MainController.swift
//  HJRevealControllerDemo
//
//  Created by Ranjeet Singh on 21/07/17.
//  Copyright © 2017 Hackj82. All rights reserved.
//

import UIKit
import HJRevealController


class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //let drawerVC    =   parent as? HJRevealViewController
        //drawerVC?.disableDrawer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickToggle(_ sender: UIButton) {
    
        let drawerVC    =   parent as? HJRevealViewController
        if drawerVC?.drawerState == .Open {
            
            drawerVC?.closeDrawer()
        } else {
            drawerVC?.openDrawer()
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
