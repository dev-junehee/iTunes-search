//
//  StorageViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/10/24.
//

import Foundation

final class StorageViewController: BaseViewController {
    
    
    override func configureViewController() {
        navigationItem.title = Constant.Title.storage
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
}
