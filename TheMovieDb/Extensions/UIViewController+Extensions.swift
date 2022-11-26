//
//  UIViewController+Extensions.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 20/01/22.
//

import UIKit

extension UIViewController {
    public convenience init(backgroundColor: UIColor) {
        self.init()
        self.view.backgroundColor = backgroundColor
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
