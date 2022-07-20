//
//  SimpleAnimationViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class SimpleAnimationViewController: UIViewController {
    
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.setTitle("ColorButton", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .yellow
        button.layer.backgroundColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(colorButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

/*
 view.topAnchor하면 진짜 꼭대기랑 매칭되는 것이다.
 view.safeAreaLayoutGuide.topAnchor와 매칭하면 Safe존을 제외한 top과 매칭된다.
 */
