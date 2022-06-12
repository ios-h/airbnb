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
    
    private let locationView: CommonTwoLabelView = {
        let view = CommonTwoLabelView()
        view.configure(title: "위치", text: "양재")
        return view
    }()
    
    private let dateView: CommonTwoLabelView = {
        let view = CommonTwoLabelView()
        view.configure(title: "체크인/체크아웃", text: "5월 17일 - 6월 4일")
        return view
    }()
    
    private let chargeView: CommonTwoLabelView = {
        let view = CommonTwoLabelView()
        view.configure(title: "요금", text: "₩100,000 - ₩1,000,000+")
        return view
    }()

    private let personCountView: CommonTwoLabelView = {
        let view = CommonTwoLabelView()
        view.configure(title: "인원", text: "게스트 3명")
        return view
    }()
    
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
        
        verticalStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.height.equalToSuperview()
        }
    }
}
