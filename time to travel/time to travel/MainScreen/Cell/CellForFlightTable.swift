//
//  CellForFlightTable.swift
//  time to travel
//
//  Created by Георгий Ксенодохов on 03.08.2023.
//

import UIKit
import SnapKit

class CellForFlightTable : UITableViewCell {
    
    var likedStatus = false
    
    var startDate : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    var endDate : UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    var price : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    var departureCity : UILabel = {
        var label = UILabel()
        label.lineBreakMode = .byTruncatingMiddle
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    var arrivalCity : UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingMiddle
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var likeImage = UIImageView(image: UIImage(systemName: "heart"))
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell() {
        addSubview(likeImage)
        addSubview(departureCity)
        addSubview(arrivalCity)
        addSubview(startDate)
        addSubview(endDate)
        addSubview(price)
        likeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        departureCity.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
        }
        startDate.snp.makeConstraints { make in
            make.top.equalTo(departureCity.snp_bottomMargin).offset(10)
            make.left.equalToSuperview().offset(5)
            make.right.equalTo(endDate.snp_leftMargin).offset(-10)
        }
        arrivalCity.snp.makeConstraints { make in
            make.right.equalTo(likeImage.snp_rightMargin).offset(-20)
            make.top.equalToSuperview().offset(5)
        }
        endDate.snp.makeConstraints { make in
            make.top.equalTo(arrivalCity.snp_bottomMargin).offset(10)
            make.right.equalTo(likeImage.snp_leftMargin).offset(-20)
            
        }
        price.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func config(model : ModelOfCell){
        var startdateString = model.startDate
        var endDateString = model.endDate
        startdateString.removeLast(19)
        endDateString.removeLast(19)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormat.date(from: startdateString)
        let endDate = dateFormat.date(from: endDateString)
        self.startDate.text = "Дата отправления: \(String(dateFormat.string(from: startDate!)))"
        self.endDate.text = "Дата возвращения: \(String(dateFormat.string(from: endDate!)))"
        departureCity.text = model.startCity + " " + model.startLocationCode
        arrivalCity.text = model.endCity + " " + model.endLocationCode
        price.text = "Цена: \(String(model.price)) ₽"
        
        
    }
    
}
