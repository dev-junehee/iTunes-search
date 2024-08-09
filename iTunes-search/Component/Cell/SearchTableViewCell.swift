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
    
    private lazy var labelStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.addArrangedSubview(appNameLabel)
        stack.addArrangedSubview(artistNameLabel)
        return stack
    }()
    
    let appNameLabel = {
        let label = UILabel()
        label.font = Font.bold18
        label.textColor = Color.black
        return label
    }()
    
    let artistNameLabel = {
        let label = UILabel()
        label.font = Font.light12
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
        [appImage, labelStack, downloadButton].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        appImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        labelStack.snp.makeConstraints {
            $0.centerY.equalTo(appImage)
            $0.leading.equalTo(appImage.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(labelStack)
            $0.bottom.equalTo(artistNameLabel.snp.top)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(labelStack)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appImage)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
}
