//
//  HJCustomSegue.swift
//  HJRevealController
//
//  Created by Ranjeet Singh on 31/07/17.
//
//

import UIKit

public class HJCustomDrawerSegue: UIStoryboardSegue {
    
    final override public func perform() {
        print("custom drawer")
        if let sourceViewController = source as? HJRevealViewController {
            sourceViewController.drawerViewController = destination
        } else {
            assertionFailure("SourceViewController must be HJRevealViewController!")
        }
    }
    
}
