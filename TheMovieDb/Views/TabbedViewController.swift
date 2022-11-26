//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

final class TabbedViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "titulo"
//        navigationController?.navigationBar.isTranslucent = false

        setViewControllers()
        setBar()
    }

    private func setViewControllers() {
        
        let bgColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
                    
        let homeVC = HomeView(backgroundColor: bgColor)
        let searchVC = SearchView(backgroundColor: bgColor)

        setViewControllers([homeVC, searchVC], animated: false)
    }
    
    private func setBar() {
        
        setBarTintColor()
        
        guard let barItems = tabBar.items else {
            return
        }
        
        for (i, item) in barItems.enumerated() {
            item.image = UIImage(systemName: AppConstants.ImgResource.iconImg[i])
        }

    }
    
    private func setBarTintColor() {
        
        // From ios15 istranslucent is set to true by deafault, making it slightly different to set the barTintColor
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
           
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            
        } else {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
        }
    }
    
    private func setNavBar() {
        let navBarColor = UIColor(fromHex: AppConstants.Color.navBarColor) ?? UIColor.white
        UINavigationBar.appearance().barTintColor = navBarColor

//        navigationController?.navigationBar.barTintColor = navBarColor
    }
}
