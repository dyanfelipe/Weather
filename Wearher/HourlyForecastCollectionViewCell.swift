//
//  HourlyForecastCollectionViewCell.swift
//  Wearher
//
//  Created by Dyan on 4/4/24.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
  
  static let indentifier: String = "HourlyForecast"
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [hourLabel, iconImageView, temperatureLabel])
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 4
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    stackView.layer.borderWidth = 1
    stackView.layer.cornerRadius = 20
    stackView.layer.borderColor = UIColor.primaryColor?.cgColor
    return stackView
  }()
  
  private lazy var hourLabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "13:00"
    label.textColor = .constrastColor
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
    return label
  }()
  
  private lazy var temperatureLabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "25°C"
    label.textAlignment = .center
    label.textColor = .constrastColor
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    return label
  }()
  
  private lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "sunIcon")
    imageView.contentMode = .scaleAspectFit
    return  imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    setHierarchy()
    setConstraints()
  }
  
  private func setHierarchy() {
    contentView.addSubview(stackView)
  }

  private func setConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    ])
    
    NSLayoutConstraint.activate([
      iconImageView.heightAnchor.constraint(equalToConstant: 33)
    ])
  }
}
