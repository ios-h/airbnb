//
//  CommonTwoLabelView.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/13.
//

import UIKit

final class CommonTwoLabelView: UIView {
    
    func configure(title: String, text: String) {
        titleLabel.text = title
        inputLabel.text = text
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let titleLabel = CustomLabel(color: .customBlack,
                                            text: "위치", font: .systemFont(ofSize: 17, weight: .medium))
    private let inputLabel = CustomLabel(color: .gray3,
                                                text: "양재", font: .systemFont(ofSize: 17, weight: .medium))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        addSubview(lineView)
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(inputLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        lineView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(0.4)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(lineView.snp.bottom)
        }
    
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        inputLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
    }
}
