//
//  LayoutAnimationViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/27.
//

import UIKit

class LayoutAnimationViewController: UIViewController {
    
    private var isZoom: Bool = false
    
    // MARK: 1. NSLayoutConstraints 변수 만들기
    var fatherWidthLayout: NSLayoutConstraint!
    
    private let grandFatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sonView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(zoomAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(grandFatherView)
        grandFatherView.addSubview(fatherView)
        fatherView.addSubview(sonView)
        
        makeConstraints()
    }
    
    @objc func zoomAction() {
        isZoom.toggle()
        // MARK: 4. 값 변경
        fatherWidthLayout.constant = isZoom ? 100 : 30
        
        // MARK: 5. 바뀐 값을 기준으로 layoutIfNeeded()해서 다시 뷰를 새로 그려줌. 이를 animate에 넣어서 애니메이션 발동하도록 함.
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    /*
     MARK: 참고 - self.view.updateConstraints()도 있지만 이는 animation은 먹히지않음.
     부모뷰와 서브뷰의 사이즈 구성이 처음부터 모두 LayoutConstraints로 잡혀있어야 함께 커지고 함께 이동하는 것이 가능하다.
     이런 constraints의 경우 스토리보드로 구성하는 것이 훨씬 쉬울 수 있다.
     */
    
    private func makeConstraints() {
        // MARK: 2. 변수에 값 할당.
        fatherWidthLayout = fatherView.leftAnchor.constraint(equalTo: grandFatherView.leftAnchor, constant: 50)
        
        let grandFatherConstraints = [
            grandFatherView.topAnchor.constraint(equalTo: view.topAnchor),
            grandFatherView.leftAnchor.constraint(equalTo: view.leftAnchor),
            grandFatherView.rightAnchor.constraint(equalTo: view.rightAnchor),
            grandFatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let fatherConstraints = [
            fatherView.topAnchor.constraint(equalTo: grandFatherView.topAnchor, constant: 200),
            fatherWidthLayout!, // MARK: 3. 변수를 NSLayoutConstraints배열에 추가.
            fatherView.rightAnchor.constraint(equalTo: grandFatherView.rightAnchor, constant: -50),
            fatherView.bottomAnchor.constraint(equalTo: grandFatherView.bottomAnchor, constant: -200)
        ]
        let sonConstraints = [
            sonView.topAnchor.constraint(equalTo: fatherView.centerYAnchor),
            sonView.leftAnchor.constraint(equalTo: fatherView.leftAnchor, constant: 100),
            sonView.rightAnchor.constraint(equalTo: fatherView.rightAnchor, constant: -30),
            sonView.bottomAnchor.constraint(equalTo: fatherView.bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(grandFatherConstraints)
        NSLayoutConstraint.activate(fatherConstraints)
        NSLayoutConstraint.activate(sonConstraints)
    }
}
