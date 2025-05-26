//
//  DashboardView.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import UIKit

final class DashboardView: UIView {
    
    private lazy var backgroundImageView: UIImageView = .make(image: UIImage(named: "gingerbread-shake"), contentMode: .scaleAspectFill)
    
    private lazy var logoImageView: UIImageView = .make(image: UIImage(named: "logo"), accessibilityIdentifier: "Gousto logo")
    
    private lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primaryBackground")
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = .make(title: NSLocalizedString("dashboard.content.title",
                                                                          comment: "A title for the dashboard content"),
                                                 font: .systemFont(ofSize: 22,
                                                                   weight: .semibold))
    
    private lazy var introductionLabel: UILabel = .make(title: NSLocalizedString("dashboard.content.introduction", comment: "A brief introduction to Gousto"),
                                                        font: .systemFont(ofSize: 16))

    
    private lazy var countdownGuide: UILayoutGuide = UILayoutGuide()
    
    lazy var countdownLabel: UILabel = .make(title: "00:00:00",
                                             font: .systemFont(ofSize: 30,
                                                               weight: .semibold),
                                             textColor: UIColor(named: "brandRed"))

    
    lazy var marketplaceButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("dashboard.button.marketplace_title", comment: "Marketplace button title"), for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = UIColor(named: "primaryControlBackground")
        button.setTitleColor(UIColor(named: "primaryControlText"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 3
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews() {
        addSubview(backgroundImageView)
        addSubview(contentContainer)
        
        [titleLabel, introductionLabel].forEach {
            contentContainer.addSubview($0)
        }
        
        contentContainer.addLayoutGuide(countdownGuide)
        
        [countdownLabel,marketplaceButton].forEach {
            contentContainer.addSubview($0)
        }
        
        addSubview(logoImageView)
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: contentContainer.topAnchor),
            
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.readableContentGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.readableContentGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            
            introductionLabel.leadingAnchor.constraint(equalTo: contentContainer.readableContentGuide.leadingAnchor),
            introductionLabel.trailingAnchor.constraint(equalTo: contentContainer.readableContentGuide.trailingAnchor),
            introductionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            countdownGuide.leadingAnchor.constraint(equalTo: contentContainer.readableContentGuide.leadingAnchor),
            countdownGuide.trailingAnchor.constraint(equalTo: contentContainer.readableContentGuide.trailingAnchor),
            countdownGuide.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor),
            countdownGuide.bottomAnchor.constraint(equalTo: marketplaceButton.topAnchor),
            
            countdownLabel.centerYAnchor.constraint(equalTo: countdownGuide.centerYAnchor),
            countdownLabel.centerXAnchor.constraint(equalTo: countdownGuide.centerXAnchor),
            countdownLabel.leadingAnchor.constraint(greaterThanOrEqualTo: countdownGuide.leadingAnchor),
            countdownLabel.trailingAnchor.constraint(greaterThanOrEqualTo: countdownGuide.trailingAnchor),
            
            marketplaceButton.leadingAnchor.constraint(equalTo: contentContainer.readableContentGuide.leadingAnchor),
            marketplaceButton.trailingAnchor.constraint(equalTo: contentContainer.readableContentGuide.trailingAnchor),
            marketplaceButton.heightAnchor.constraint(equalToConstant: 44),
            marketplaceButton.bottomAnchor.constraint(equalTo: contentContainer.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
