//
//  ViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class MainViewController: UIViewController {
    
    private let listContents = [
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
    }
    
    private func configureNavBar() {
        title = "UIKit Study"
        
        //barStyle - status bar의 컬러 컨셉도 함께 지정된다.
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
        
    }
}

