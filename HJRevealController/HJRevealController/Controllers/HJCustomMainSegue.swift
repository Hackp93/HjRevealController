//
//  HJCustomMainSegue.swift
//  HJRevealController
//
//  Created by Ranjeet Singh on 01/08/17.
//
//

import UIKit

public class HJCustomMainSegue: UIStoryboardSegue {

    
    final override public func perform() {
        print("main")
        if let sourceViewController = source as? HJRevealViewController {
            sourceViewController.mainViewController = destination
        } else {
            assertionFailure("SourceViewController must be HJRevealViewController!")
        }
    }
    
}
