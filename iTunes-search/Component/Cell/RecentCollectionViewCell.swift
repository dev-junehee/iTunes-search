//
//  RecentCollectionViewCell.swift
//  iTunes-search
//
//  Created by junehee on 8/10/24.
//

import UIKit
import SnapKit

final class RecentCollectionViewCell: BaseCollectionViewCell {
    
    var label = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = Color.lightGray
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
