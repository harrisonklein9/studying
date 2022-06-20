//
//  ProgramaticCollectionViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/ 18/22.
//

import UIKit

class ProgramaticCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        let columnCount = randomColorGrid[0].count
        let width = view.bounds.width / CGFloat(columnCount)
        flowLayout.itemSize = CGSize(width: width, height: width)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "RandomCell")
        
        
        return collectionView
    }()
    
    private lazy var randomColorGrid: [[UIColor]] = {
        let rows = Int.random(in: 1...10)
        let columns = Int.random(in: 1...10)
        var grid = [[UIColor]]()
        
        for i in 0..<rows {
            var column = [UIColor]()
            for j in 0..<columns {
                column.append(UIColor.random)
            }
            grid.append(column)
        }
        return grid
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Programatic Collection View"
        view.addSubview(collectionView)
    }
}

extension ProgramaticCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return randomColorGrid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomColorGrid[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
        cell.backgroundColor = randomColorGrid[indexPath.section][indexPath.item]
        return cell
    }
}

extension UIColor {
    static var random: UIColor {
        let randomInt = Int.random(in: 0...5)
        switch randomInt {
            case 0:
                return .red
            case 1:
                return .yellow
            case 2:
                return .green
            case 3:
                return .blue
            case 4:
                return .purple
            case 5:
                return .orange
            default:
                break
        }
        return .black
    }
}
