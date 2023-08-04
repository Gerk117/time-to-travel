//
//  ExstensionMainScreen.swift
//  time to travel
//
//  Created by Георгий Ксенодохов on 02.08.2023.
//

import UIKit
extension MainScreen : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelOfMain.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CellForFlightTable
        cell?.config(model: modelOfMain.data[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flightScreen = FlightScreen()
        flightScreen.cell = tableView.cellForRow(at: indexPath) as? CellForFlightTable
        navigationController?.pushViewController(flightScreen, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

