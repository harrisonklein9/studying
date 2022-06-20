//
//  NewTopicArchViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

class NewTopicArchViewController: EditableViewController {
    
    private lazy var dataSource: TopicCollectionViewDataSource? = {
        if let data = NewTopicArchDataSource.data {
            return TopicCollectionViewDataSource(data: data.topicItems)
        }
        return nil
    }()
    
    private lazy var delegateFlowLayout: TopicListCollectionViewDelegateFlowLayout? = {
        if let data = NewTopicArchDataSource.data {
            return TopicListCollectionViewDelegateFlowLayout(data: data.topicItems)
        }
        return nil
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
        title = "New Topic Arch"
        
        collectionView.register(CarouselItemCellConfigurator.nib, forCellWithReuseIdentifier: CarouselItemCellConfigurator.reuseId)
        collectionView.register(ListItemCellConfigurator.nib, forCellWithReuseIdentifier: ListItemCellConfigurator.reuseId)
        setupDataSourceAndDelegate()
        super.viewDidLoad()
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: UIImage(systemName: "doc"), style: .plain, target: self, action: #selector(docButtonPressed)))
    }
    
    @objc private func docButtonPressed() {
        navigationController?.pushViewController(DocumentationViewController(), animated: true)
    }
    
    private func setupDataSourceAndDelegate() {
        if let dataSource = dataSource,
           let delegateFlowLayout = delegateFlowLayout {
            collectionView.dataSource = dataSource
            collectionView.delegate = delegateFlowLayout
        }
    }
}
