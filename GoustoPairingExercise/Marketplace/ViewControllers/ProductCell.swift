//
//  ProductCell.swift
//  Marketplace
//
//  Created by Nayana NP on 24/05/2025.
//

import UIKit

class ProductCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var container: UIStackView = {
        let container = UIStackView(arrangedSubviews: [productImageView, stackView])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.spacing = 12
        container.alignment = .center
        return container
    }()

    // MARK: - Override methods
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: Product) {
        
        titleLabel.text = product.title
        descriptionLabel.text = product.productDescription
        productImageView.image = UIImage(systemName: "photo")
        
        if let url = product.imageURL {
            productImageView.setImage(from: url, placeholder: UIImage(systemName: "photo"))
        }
    }
}

// MARK: - Private methods

private extension ProductCell {
    
    func setUpConstraints() {

        productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
