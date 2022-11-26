//
//  NavViewController.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 01/02/22.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
    }
    
    private func setNavBar() {
        let navBarColor = UIColor(fromHex: AppConstants.Color.navBarColor) ?? UIColor.white
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navBarColor
           
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
            
        } else {
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = navBarColor
        }
        
    }
    
}
