//
//  ViewController.swift
//  Wearher
//
//  Created by Dyan on 3/23/24.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var backgroundView: UIImageView =  {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "background")
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var headerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .constrastColor
    view.layer.cornerRadius = 20
    return view
  }()
  
  private lazy var cityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    label.textAlignment = .center
    label.textColor = .primaryColor
    
    label.drawText(in: .infinite)
    label.text = "Belo Horizonte"
    return label
  }()
  
  private lazy var humidityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Umidade"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .constrastColor
    return label
  }()
  
  private lazy var humidityValueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "1000mm"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .constrastColor
    return label
  }()
  
  private lazy var humidityStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()
  
  private lazy var windLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Vento"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .constrastColor
    return label
  }()
  
  private lazy var windValueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "10km/h"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .constrastColor
    return label
  }()
  
  private lazy var windStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()
  
  private lazy var statsStackView = {
    let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 3
    stackView.backgroundColor = .softGrayColor
    stackView.layer.cornerRadius = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
    return stackView
  }()
  
  private lazy var hourlyForecastLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .constrastColor
    label.text = "PREVISÃO POR HORA"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var hourlyCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 67, height: 84)
    layout.sectionInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.indentifier)
    return collectionView
  }()
  
  private lazy var temperatureLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
    label.textAlignment = .left
    label.textColor = .primaryColor
    
    label.drawText(in: .infinite)
    label.text = "25°C"
    return label
  }()
  
  private lazy var weatherIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "sunIcon")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var dailyForecastLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .constrastColor
    label.text = "PROXIMOS DIAS"
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var dailyForecastTableView: UITableView = {
    let  tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .clear
    tableView.separatorColor = UIColor(white: 1, alpha: 0.3)
    tableView.dataSource = self
    tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.indentifier)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = .red
    setHierarchy()
    setConstraints()
  }
  
  private func setHierarchy() {
    view.addSubview(backgroundView)
    view.addSubview(headerView)
    view.addSubview(statsStackView)
    view.addSubview(hourlyForecastLabel)
    view.addSubview(hourlyCollectionView)
    view.addSubview(dailyForecastLabel)
    view.addSubview(dailyForecastTableView)
    
    headerView.addSubview(cityLabel)
    headerView.addSubview(temperatureLabel)
    headerView.addSubview(weatherIcon)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      headerView.heightAnchor.constraint(equalToConstant: 150),
    ])
    
    NSLayoutConstraint.activate([
      cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
      cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
      cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
      cityLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
    
    NSLayoutConstraint.activate([
      temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 15),
      temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26)
    ])
    
    NSLayoutConstraint.activate([
      weatherIcon.heightAnchor.constraint(equalToConstant: 86),
      weatherIcon.widthAnchor.constraint(equalToConstant: 86),
      weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
      weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
      weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
    ])
    
    NSLayoutConstraint.activate([
      statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
      statsStackView.widthAnchor.constraint(equalToConstant: 206),
      statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 29),
      hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      hourlyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
    ])
    
    NSLayoutConstraint.activate([
      hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
      hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
      hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 29),
      dailyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      dailyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
    ])
    
    NSLayoutConstraint.activate([
      dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 16),
      dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.indentifier, for: indexPath)
    return cell
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.indentifier, for: indexPath)
    return cell
  }
  
  
}
