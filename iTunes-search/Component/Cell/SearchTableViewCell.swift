//
//  SearchTableViewCell.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    let appImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = Color.lightGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    let appName = {
        let label = UILabel()
        label.font = Font.bold18
        label.textColor = Color.black
        return label
    }()
    
    private let downloadButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Color.lightGray
        config.baseForegroundColor = Color.blue
        config.cornerStyle = .capsule
        
        var title = AttributedString(Constant.Button.download)
        title.font = Font.bold14
        config.attributedTitle = title
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    override func configureHierarchy() {
        [appImage, appName, downloadButton].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        appImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appName.snp.makeConstraints {
            $0.centerY.equalTo(appImage)
            $0.leading.equalTo(appImage.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appImage)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
}
