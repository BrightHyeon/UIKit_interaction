//
//  ViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class TableViewController: UIViewController {
    
    private let listContents = [1, 2, 3]
    
    private let mainTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainTable)
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainTable.frame = view.bounds
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(listContents[indexPath.row])"
        return cell
    }
}
