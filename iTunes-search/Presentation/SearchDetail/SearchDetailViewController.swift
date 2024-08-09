//
//  SearchDetailViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit
import SnapKit

final class SearchDetailViewController: BaseViewController {
    
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
        stack.alignment = .top
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
        label.textColor = Color.lightGray
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchDetailViewController")
    }
    
    override func configureViewController() {
        [albumImage, albumLabelStack, downloadButton].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        albumImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.size.equalTo(100)
        }
        
        albumLabelStack.snp.makeConstraints {
            $0.top.equalTo(albumImage)
            $0.leading.equalTo(albumImage.snp.trailing).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        albumNameLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(albumLabelStack)
            $0.height.equalTo(30)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(albumNameLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(albumLabelStack)
        }
        
        downloadButton.snp.makeConstraints {
            $0.leading.equalTo(albumImage.snp.trailing).offset(16)
            $0.bottom.equalTo(albumImage.snp.bottom)
            $0.width.equalTo(70)
        }
        
        albumNameLabel.text = "지저스 크라이스트 수퍼스타 Vol.3"
        artistNameLabel.text = "Various Artists"
    
    }
    
}
