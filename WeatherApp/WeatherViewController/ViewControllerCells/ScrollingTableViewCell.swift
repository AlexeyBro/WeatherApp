//
//  ChanginsSettingsCell.swift
//  WeatherApp
//
//  Created by Alex on 21.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class ScrollingTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    var dataSource : [List]?
    var emptyDataSource : [Date]!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        return collection
    } ()
    
    private func setupView() {
        
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "id")
        
        [
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstraints()
//        loadData()
    }
    
    private func setupConstraints() {
        contentView.layoutMargins = UIEdgeInsets(top: Space.double,
                                                 left: Space.double,
                                                 bottom: Space.double,
                                                 right: Space.double)
        let constrains = [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
        
    func loadData() {
        emptyDataSource = Converter.shared.twentyThreeHourItems
        if QueryService.shared.weatherModel != nil {
            dataSource = QueryService.shared.weatherModel.list
        }
    }

        
}


// MARK: - UICollectionViewDataSource
    
extension ScrollingTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? emptyDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! HourlyWeatherCell
        if let dataSource = dataSource {
            let source = dataSource[indexPath.row]
            Converter.shared.weatherList = source
            itemCell.tempText = "\(Converter.shared.temp)"
            itemCell.iconImage = UIImage(named: source.weather[0].main)
        } else {
            Converter.shared.currentDayAndTime = emptyDataSource[indexPath.row]
        }
        
        itemCell.dayText = Converter.shared.month
        itemCell.timeText = Converter.shared.hoursAndMinutes
        cell = itemCell
        
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ScrollingTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 140)
    }
}
