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
        "ScrollView Setting"
    ]
    
    private let mainTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        
        view.addSubview(mainTable)
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainTable.frame = view.bounds
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
        default:
            return UIViewController()
        }
    }
}

/*
 <Insights>
 
 7/20
 - mainTable.frame = view.bounds
   혹은
 - translate... = false & layoutConstraints 조합
   등으로 크기를 지정하여 UITableView를 View에 띄울 수 있다.
 - 둘 다 컨텐츠가 적은 상황에도 스크롤이 가능하다. (default list임) -> 예상이랑 다르네...
 */
