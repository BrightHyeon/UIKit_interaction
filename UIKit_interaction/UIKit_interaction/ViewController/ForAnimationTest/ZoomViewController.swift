//
//  ViewController.swift
//  HelpMeUIKitSoHard
//
//  Created by Byeon jinha on 2022/07/12.
//

import UIKit

extension CGFloat {
    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height
}


class ZoomViewController: UIViewController {
    var isBig = false
    let image: UIImage = UIImage(named: "background")!
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    private lazy var label: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(
            x: backgroundImage.frame.minX + width / 4,
            y: backgroundImage.frame.minY + width / 4,
            width: backgroundImage.frame.width / 3,
            height: backgroundImage.frame.width / 3))
        button.backgroundColor = .red
        button.setTitle("test", for: .normal)
        button.addTarget(self, action: #selector(onClickMyButton), for: .touchUpInside)
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.backgroundColor = .systemMint
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let posX: CGFloat = 0
        let posY: CGFloat = 0
        let backgroundImage: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: width, height: height))
        backgroundImage.image = self.image
        
        return backgroundImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemBackground 동적인 생깔
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.label)
        
    }
    
    @objc internal func onClickMyButton() {
        isBig.toggle()
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.backgroundImage.frame = CGRect(
                x: self.isBig ? -100 : 0,
                y: self.isBig ? -100 : 0,
                width: self.width*CGFloat(self.isBig ? 2 : 1),
                height: self.height*CGFloat(self.isBig ? 2 : 1))
            self.label.frame = CGRect(
                x: self.backgroundImage.frame.minX + self.backgroundImage.frame.width / 4,
                y: self.backgroundImage.frame.minY + self.backgroundImage.frame.width / 4,
                width: self.backgroundImage.frame.width / 3,
                height: self.backgroundImage.frame.width / 3)
        }
        animator.startAnimation()
        
        if isBig {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.view.addSubview(self.textLabel)
                NSLayoutConstraint.activate([
                    self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    self.textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    self.textLabel.widthAnchor.constraint(equalToConstant: 100),
                    self.textLabel.heightAnchor.constraint(equalToConstant: 100)
                ])
            }
            
        } else {
            textLabel.removeFromSuperview()
        }
    }
    
}

