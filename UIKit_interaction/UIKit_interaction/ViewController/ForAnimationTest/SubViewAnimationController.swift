//
//  SubViewAnimationController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import UIKit

class SubViewAnimationController: UIViewController {
    
    private let backView: UIImageView = {
        let view = UIImageView(frame: UIScreen.main.bounds)
        view.image = UIImage(named: "background")
        view.image?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blackView: UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        view.backgroundColor = .black
        return view
    }()
    
    private let zoomButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 100))
        button.setTitle("Zoom Up", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(backView)
        backView.addSubview(blackView)
        
        backView.addSubview(zoomButton)
        zoomButton.addTarget(self, action: #selector(zoomInAction), for: .touchUpInside)
    }
    
    @objc func zoomInAction() {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            self.backView.frame = CGRect(x: -500, y: -500, width: .screenW*2, height: .screenH*2)
            self.blackView.frame = self.backView.bounds
            
        }
    }
}
