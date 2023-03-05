//
//  ViewController.swift
//  CompositionalLayoutPractise
//
//  Created by Ilkin Murtuzayev on 26.02.23.
//

import UIKit

class ViewController: UIViewController{

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ViewController.createLayout()
    )
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier )
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        
    }

   
    static func createLayout() -> UICollectionViewCompositionalLayout {
        
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1)
            )
        )
        
     item.contentInsets = NSDirectionalEdgeInsets(top:0, leading:2 , bottom:2, trailing: 2)
        
        
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/3)
             )
        )
        
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 2, trailing: 2)
        let VerticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                
            widthDimension: .fractionalWidth(1/3),
            
            heightDimension: .fractionalHeight(1)
            
             ),
            repeatingSubitem: verticalStackItem,
            count:3)
        
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3 ),
                heightDimension:.fractionalHeight(1))
        )
        
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:2, bottom:0, trailing:0)
        let tripletHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize:     NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/3)),
            repeatingSubitem: tripletItem,
            count: 3 )
        
        tripletHorizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom:2, trailing:2)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(2/3))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [
        item,
        VerticalStackGroup
        
        ])
        
        
        let verticalGroup =  NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1/2))  , subitems: [horizontalGroup,tripletHorizontalGroup ])
        
        
        
        // Sections
     
        let section = NSCollectionLayoutSection(group:verticalGroup)
        

        
        
        
        // Return
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    
    

}

extension ViewController: UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath)
        
        
        return cell
    }
    
   
    
    
    
}
