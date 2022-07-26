//
//  ClearTestViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import UIKit

class ClearViewController: UIViewController {
    
    var contentIndex: Int?
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("\(contentIndex ?? 7)번째 Clear", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(tapClear), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        clearButton.frame = view.bounds
    }
    
    @objc func tapClear() {
        guard let index = contentIndex else { return }
        UserDefaults.standard.set(index + 1, forKey: "clear")
        //currentIndex == index였지만, 클리어함으로써 새로 조명이 켜질 currentIndex는 index + 1이 된다.
    }
    
}
