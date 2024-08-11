//
//  LikeMusicTableViewCell.swift
//  iTunes-search
//
//  Created by junehee on 8/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class LikeMusicTableViewCell: BaseTableViewCell {
    
    let albumImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = Color.lightGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var albumLabelStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(albumNameLabel)
        stack.addArrangedSubview(artistNameLabel)
        return stack
    }()
    
    let albumNameLabel = {
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
    
    let downloadButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Color.lightGray
        config.baseForegroundColor = Color.blue
        config.cornerStyle = .capsule
        
        var title = AttributedString(Constant.Button.cancel)
        title.font = Font.bold14
        config.attributedTitle = title
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func configureHierarchy() {
        [albumImage, albumLabelStack, downloadButton].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        albumImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        albumLabelStack.snp.makeConstraints {
            $0.centerY.equalTo(albumImage)
            $0.leading.equalTo(albumImage.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        albumNameLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(albumLabelStack)
            $0.bottom.equalTo(artistNameLabel.snp.top)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(albumNameLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(albumLabelStack)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(albumImage)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
}
