//
//  TableViewController.swift
//  AirQualityIndex
//
//  Created by Mollick, Tapash on 20/06/21.
//

import UIKit

class CityListViewController: UITableViewController {
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "City wise Air Quality Index"
        tableView.register(UINib(nibName: AirQualityIndexViewCell.identifier, bundle: nil), forCellReuseIdentifier: AirQualityIndexViewCell.identifier)
        tableView.estimatedRowHeight = 84.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        viewModel.loadData {
        }
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        self.viewModel.bindDataToController = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirQualityIndexViewCell.identifier, for: indexPath) as? AirQualityIndexViewCell else { return UITableViewCell() }
        cell.city = viewModel.item(for: indexPath.section)
        cell.selectionStyle = .none
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let chartViewController = storyBoard.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        if let city = viewModel.item(for: indexPath.section)?.city {
            chartViewController.city = city
        }
        navigationController?.pushViewController(chartViewController, animated: true)
    }
}
