//
//  ProgramaticTableViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import UIKit

class ProgramaticTableViewController: UIViewController {
    
    private let dataSource = [
        Array(repeating: 0, count: 5),
        Array(repeating: 0, count: 3),
        Array(repeating: 0, count: 30),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "exampleCell")
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        title = "Programatic Table View"
        view.addSubview(tableView)
        super.viewDidLoad()
    }
}

extension ProgramaticTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell", for: indexPath)
        cell.textLabel?.text = "Section: \(indexPath.section) Row: \(indexPath.row)"
        return cell
    }
}
