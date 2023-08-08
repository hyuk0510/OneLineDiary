//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {

    static let identifier = "SearchCollectionViewController"
    
    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()
    }
    
    func setCollectionViewLayout() {
        //cell estimated size none으로 인터페이스 빌더에서 설정할 것!
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing , right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    //1. 셀의 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchList.count
    }
    
    //2.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.backgroundColor = .darkGray
        
        cell.contentsLabel.text = "\(searchList[indexPath.row])"
        
        return cell
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        
        collectionView.reloadData()
        searchBar.showsCancelButton = true
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList.removeAll()
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        for item in list {
            if item.contains(searchText) {
                searchList.append(item)
            }
        }
        
        collectionView.reloadData()
    }
}
