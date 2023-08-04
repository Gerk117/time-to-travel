//
//  FlightScreen.swift
//  time to travel
//
//  Created by Георгий Ксенодохов on 02.08.2023.
//

import UIKit

class FlightScreen : UIViewController {
    
    var arrivalCity : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "Город прибытия:"
        return label
    }()
    var departureCity : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "Город отправления:"
        return label
    }()
    
    
    lazy var likedButton : UIButton = {
        var button = UIButton()
        button.addAction(UIAction(handler: { _ in
            if self.cell.likedStatus {
                self.cell.likeImage.image = UIImage(systemName: "heart")
                self.cell.likedStatus = !self.cell.likedStatus
                self.likedButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                self.cell.likeImage.image = UIImage(systemName: "heart.fill")
                self.cell.likedStatus = !self.cell.likedStatus
                self.likedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    weak var cell : CellForFlightTable!
    
    private var informationAboutFlightStack : UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 20
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(informationAboutFlightStack)
        setupScreen()
        config(cell)
        
    }
    func setupScreen(){
        informationAboutFlightStack.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        if cell.likedStatus {
            likedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likedButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        view.backgroundColor = .white
        navigationItem.setRightBarButton(UIBarButtonItem(customView: likedButton), animated: true)
        
    }
    func createLabel(text : String) -> UILabel{
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = text
        return label
    }
    
    func config(_ cell : CellForFlightTable){
        informationAboutFlightStack.addArrangedSubview(departureCity)
        informationAboutFlightStack.addArrangedSubview(createLabel(text: cell.departureCity.text ?? ""))
        informationAboutFlightStack.addArrangedSubview(createLabel(text: cell.startDate.text ?? ""))
        informationAboutFlightStack.addArrangedSubview(arrivalCity)
        informationAboutFlightStack.addArrangedSubview(createLabel(text: cell.arrivalCity.text ?? ""))
        informationAboutFlightStack.addArrangedSubview(createLabel(text: cell.endDate.text ?? ""))
        informationAboutFlightStack.addArrangedSubview(createLabel(text: cell.price.text ?? ""))
    }
    
    
}
