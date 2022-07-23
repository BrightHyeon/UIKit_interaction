//
//  ViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class MainViewController: UIViewController {
    
    private let listContents = [
        "TableView Setting",
        "CollectionView Setting",
        "ScrollView Setting",
        "Simple Animation",
        "Zoom Animation",
        "Go to Main"
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listContents[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = makeVCInstance(name: listContents[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension MainViewController {
    func configureNavBar() {
        title = "UIKit Study"
        
        //barStyle - status bar의 컬러 컨셉도 함께 지정된다.
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func makeVCInstance(name destination: String) -> UIViewController {
        switch destination {
        case "TableView Setting":
            return TableViewController()
        case "CollectionView Setting":
            return CollectionViewController()
        case "ScrollView Setting":
            return ScrollViewController()
        case "Simple Animation":
            return SimpleAnimationViewController()
        case "Zoom Animation":
            return ZoomViewController()
        case "Go to Main":
            return MainViewController()
        default:
            return UIViewController()
        }
    }
}

/*
 <Insights>
 
 MARK: 7/20
 
 - TableView, CollectionView 등에서 크기를 지정하는 법
 1) mainTable.frame = view.bounds
    OR
 2) translate... = false && layoutConstraints 조합
 3) TODO: tableView.contentSize = view.bounds.size
 
 - Scroll 가능 여부
 1) 자신의 크기보다 내부 Subviews들의 크기 합이 더 작을 때
    - UITableView: 스크롤 가능
    - UICollectionView: 스크롤 불가능
    - UIScrollView: 스크롤 불가능
 */
