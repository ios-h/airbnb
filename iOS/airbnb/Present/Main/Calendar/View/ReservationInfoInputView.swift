//
//  ReservationInfoInputView.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import UIKit

final class ReservationInfoInputView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    private let locationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let locationLabel = CustomLabel(color: .customBlack,
                                            text: "위치", font: .systemFont(ofSize: 17, weight: .medium))
    private let locatinInputLabel = CustomLabel(color: .gray3,
                                                text: "양재", font: .systemFont(ofSize: 17, weight: .medium))
    
    private let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dateLabel = CustomLabel(color: .customBlack,
                                            text: "체크인/체크아웃", font: .systemFont(ofSize: 17, weight: .medium))
    private let dateInputLabel = CustomLabel(color: .gray3,
                                                text: "5월 17일 - 6월 4일", font: .systemFont(ofSize: 17, weight: .medium))
    
    private let chargeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let chargeLabel = CustomLabel(color: .customBlack,
                                            text: "요금", font: .systemFont(ofSize: 17, weight: .medium))
    private let chargeInputLabel = CustomLabel(color: .gray3,
                                                text: "₩100,000 - ₩1,000,000+",
                                               font: .systemFont(ofSize: 17, weight: .medium))
    
    private let personCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let personCountLabel = CustomLabel(color: .customBlack,
                                            text: "인원", font: .systemFont(ofSize: 17, weight: .medium))
    private let personCountInputLabel = CustomLabel(color: .gray3,
                                                text: "게스트 3명", font: .systemFont(ofSize: 17, weight: .medium))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        locationView.addSubview(locationLabel)
        locationView.addSubview(locatinInputLabel)
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(dateInputLabel)
        
        chargeView.addSubview(chargeLabel)
        chargeView.addSubview(chargeInputLabel)
        
        personCountView.addSubview(personCountLabel)
        personCountView.addSubview(personCountInputLabel)
        
        verticalStackView.addArrangedSubview(locationView)
        verticalStackView.addArrangedSubview(dateView)
        verticalStackView.addArrangedSubview(chargeView)
        verticalStackView.addArrangedSubview(personCountView)
        
        containerView.addSubview(verticalStackView)
        addSubview(containerView)
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        locatinInputLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        dateInputLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
        
        chargeLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        chargeInputLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
        
        personCountLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        personCountInputLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.height.equalToSuperview()
        }
    }
}
