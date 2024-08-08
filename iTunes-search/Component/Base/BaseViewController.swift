//
//  BaseViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        configureViewController()
        configureHierarchy()
        configureLayout()
    }
    
    func configureViewController() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
}
