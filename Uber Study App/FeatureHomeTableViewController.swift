//
//  ViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import UIKit

class FeatureHomeTableViewController: UITableViewController {
    
    private var features = [
        FeatureRow(name: "Programatic Table View", onTap: {
            $0?.pushViewController(ProgramaticTableViewController(), animated: true)
        }),
        FeatureRow(name: "Programatic Collection View", onTap: {
            $0?.pushViewController(ProgramaticCollectionViewController(), animated: true)
        }),
        FeatureRow(name: "Image Loader", onTap: {
            $0?.pushViewController(ImageLoaderCollectionViewController(), animated: true)
        }),
        FeatureRow(name: "New Topic Architecture", onTap: {
            $0?.pushViewController(NewTopicArchViewController(), animated: true)
        })
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }


}

extension FeatureHomeTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        features[indexPath.row].onTap(navigationController)
    }
}

extension FeatureHomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath)
        cell.textLabel?.text = features[indexPath.row].name
        return cell
    }
}
