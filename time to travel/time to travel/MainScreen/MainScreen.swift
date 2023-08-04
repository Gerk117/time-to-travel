//
//  ViewController.swift
//  time to travel
//
//  Created by Георгий Ксенодохов on 02.08.2023.
//

import UIKit
import SnapKit

class MainScreen: UIViewController {
    
    var modelOfMain = ModelOfMainScreen()
    var cellId = "CellForFlightsTable"
    
    private var tableOfFlightView : UITableView = {
        var table = UITableView()
        table.rowHeight = 60
        return table
    }()
    private var loadingIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableOfFlightView)
        view.addSubview(loadingIndicator)
        title = "Авиабилеты"
        tableOfFlightView.register(CellForFlightTable.self, forCellReuseIdentifier: cellId)
        tableOfFlightView.dataSource = self
        tableOfFlightView.delegate = self
        setupScreen()
        downloadFlightData()
        
    }
    private func downloadFlightData() {
        var request = URLRequest(url: URL(string: "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap")!)
        request.httpMethod = "post"
        request.allHTTPHeaderFields = ["authority": "vmeste.wildberries.ru",
                                       "accept":" application/json, text/plain, */*",
                                       "cache-control":" no-cache",
                                       "content-type": "application/json",
                                       "origin": "https://vmeste.wildberries.ru",
                                       "pragma": "no-cache",
                                       "referer":" https://vmeste.wildberries.ru/avia",
                                       "sec-fetch-dest":"empty",
                                       "sec-fetch-mode":"cors",
                                       "sec-fetch-site":"same-origin"
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["startLocationCode": "LED"])
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {return}
            guard let data else {return}
            print(String(decoding: data, as: UTF8.self))
            let decoder = try! JSONDecoder().decode(JsonData.self, from: data)
            var downloadedData = [ModelOfCell]()
            for i in decoder.flights {
                let model = ModelOfCell(startDate: i.startDate, endDate: i.endDate, startLocationCode: i.startLocationCode, endLocationCode: i.endLocationCode, startCity: i.startCity, endCity: i.endCity, price: i.price)
                downloadedData.append(model)
            }
            self.modelOfMain.data = downloadedData
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.removeFromSuperview()
                self.tableOfFlightView.isHidden = false
                self.tableOfFlightView.reloadData()
            }
        }.resume()
    }
    
    private func setupScreen() {
        view.backgroundColor = .white
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        tableOfFlightView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(view.safeAreaLayoutGuide)
        }
        tableOfFlightView.isHidden = true
    }
    
}

