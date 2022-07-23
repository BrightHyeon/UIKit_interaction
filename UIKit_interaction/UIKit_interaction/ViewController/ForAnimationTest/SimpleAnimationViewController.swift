//
//  SimpleAnimationViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class SimpleAnimationViewController: UIViewController {
    
    //MARK: ColorButton
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.setTitle("ColorButton", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
//        button.backgroundColor = .yellow // 둘다 매기면 layer 색으로 들어.. -> MARK: NONO! 그냥 호출순서 차이. 둘이 동일한건가...
        button.layer.backgroundColor = UIColor.red.cgColor //layer가 한 층 윗단계.
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    
    var colorCount: Int = 0
    
    @objc func changeColor() {
        UIView.animate(withDuration: 1, delay: 0) { [weak self] in
            self?.colorButton.layer.backgroundColor = UIColor(red: CGFloat.random(in: 1...200)/255,
                                                        green: CGFloat.random(in: 1...200)/255,
                                                        blue: CGFloat.random(in: 1...200)/255,
                                                        alpha: CGFloat.random(in: 1...100)/100).cgColor
            //Animation이 일어나는 동안에는 클릭으로 Animation 재시작 트리거가 안된다.
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.colorCount += 1
            if self.colorCount < 10 {
                self.changeColor()
            }
        }
    }
    
    //MARK: FrameButton
    private lazy var frameButton: UIButton = {
        let button = UIButton()
        button.setTitle("frameButton", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
//        button.backgroundColor = .yellow // 둘다 매기면 layer 색으로 들어간다.
        button.layer.backgroundColor = UIColor.green.cgColor //layer가 한 층 윗단계.
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeFrameOfFrameButton), for: .touchUpInside)
        return button
    }()
    
    var frameCount: Int = 0
    
    @objc func changeFrameOfFrameButton() {
        UIView.animate(withDuration: 1, delay: 0) {
            print(self.frameButton.frame)
            print(self.frameButton.center)
            self.frameButton.frame = CGRect(x: 100, y: 500, width: 200, height: 100)
//            self.frameButton.center = CGPoint(x: 200, y: 500)
        } completion: { _ in
            self.frameButton.frame = CGRect(x: 0, y: 200, width: 177.33333333333334, height: 34.0)
        }
    }
    
    //MARK: UIView
    private let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: SubButton
    private lazy var subButton: UIButton = {
        let button = UIButton()
        button.setTitle("subButton", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.yellow.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeFrameOfSubButton), for: .touchUpInside)
        return button
    }()
    
    @objc func changeFrameOfSubButton() {
        UIView.animate(withDuration: 1, delay: 0) {
            print(self.subButton.frame)
            self.subButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        } completion: { _ in
            self.subButton.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        }
    }
    
    //MARK: SubButton2
    private lazy var subButton2: UIButton = {
        let button = UIButton()
        button.setTitle("subButton2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.yellow.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeFrameOfSubButton2), for: .touchUpInside)
        return button
    }()
    
    @objc func changeFrameOfSubButton2() {
        UIView.animate(withDuration: 1, delay: 0) {
            print(self.subButton.frame)
            self.subButton2.frame = CGRect(x: 300, y: 300, width: 100, height: 100)
        } completion: { _ in
            self.subButton2.frame = CGRect(x: 150, y: 150, width: 100, height: 100)
        }
    }
    
    private let sizeButton: UIButton = {
        let button = UIButton()
        button.setTitle("sizeButton", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.black.cgColor
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(changeSizeOfSizeButton), for: .touchUpInside)
        return button
    }()
    
    @objc func changeSizeOfSizeButton() {
//        let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
//            self.sizeButton.frame = CGRect(x: 300, y: 500, width: 200, height: 200)
//        }
//        animator.startAnimation()
        
//        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut) {
//            self.sizeButton.frame = CGRect(x: 300, y: 500, width: 200, height: 200)
//        }

        UIView.animate(withDuration: 1) {
//            self.sizeButton.frame = CGRect(x: 300, y: 500, width: 200, height: 200)
//            self.sizeButton.alpha = 0.5
//            self.sizeButton.backgroundColor = UIColor.green
//
//            self.testView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            
            NSLayoutConstraint.activate([
                self.sizeButton.widthAnchor.constraint(equalToConstant: 200),
                self.sizeButton.heightAnchor.constraint(equalToConstant: 200),
                self.sizeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.sizeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ])
        }
    }
    
    private let testView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        uiView.backgroundColor = .orange
        return uiView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(colorButton)
        view.addSubview(frameButton)
        view.addSubview(uiView)
        uiView.addSubview(subButton)
        uiView.addSubview(subButton2)
        view.addSubview(sizeButton)
        view.addSubview(testView)
        
        sizeButton.addTarget(self, action: #selector(changeSizeOfSizeButton), for: .touchUpInside)
        
//        testView.center = view.center
        
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("viewDidLayoutSubviews 호출")
    }
    
    private func makeConstraints() {
        print("make Constraints 함수 호출")
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.2),
            
            frameButton.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 20),
            frameButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.2),
            
            uiView.topAnchor.constraint(equalTo: frameButton.bottomAnchor, constant: 20),
            uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiView.widthAnchor.constraint(equalToConstant: 300),
            uiView.heightAnchor.constraint(equalToConstant: 300),
            
            subButton.centerXAnchor.constraint(equalTo: uiView.centerXAnchor, constant: -50),
            subButton.centerYAnchor.constraint(equalTo: uiView.centerYAnchor, constant: -50),
            subButton.widthAnchor.constraint(equalToConstant: 100),
            subButton.heightAnchor.constraint(equalToConstant: 100),
            
            subButton2.centerXAnchor.constraint(equalTo: uiView.centerXAnchor, constant: 50),
            subButton2.centerYAnchor.constraint(equalTo: uiView.centerYAnchor, constant: 50),
            subButton2.widthAnchor.constraint(equalToConstant: 100),
            subButton2.heightAnchor.constraint(equalToConstant: 100),
            
            sizeButton.widthAnchor.constraint(equalToConstant: 100),
            sizeButton.heightAnchor.constraint(equalToConstant: 100),
            sizeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            sizeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
    }
}

/*
 view.topAnchor하면 진짜 꼭대기랑 매칭되는 것이다.
 view.safeAreaLayoutGuide.topAnchor와 매칭하면 Safe존을 제외한 top과 매칭된다.
 
 frame은 get용도로 쓰는 것이 좋다하셨고,
 layoutConstraints를 이용해서 배치하는 것이 좋다하셨다.
 
 근데 그러면 UI객체의 frame, bounds, center 등등을 찍었을 때 전부 0으로 나온다. 가지고 있는 값이 0이기에 원하는 애니메이션 동작이 되질않는다.
 -> 아니다. 이 후 버튼 클릭 액션 때 호출해보면 frame이 생겨있다. viewDidLoad때 동기적으로 그려나가는 것이 아니라, 그려져야하는 시점(?언젠진모름)에 그려지나보다.
 
 frame != bounds
 그러면 frame과 bounds가 무엇일까...
 
 -> 출처: https://zeddios.tistory.com/203 zedd
 
 frame 출력해보고 동일한 CGRect값을 할당하면 아무런 애니메이션도 일어나지않는다.
 frame 출력해보고 동일한 width, height에 x, y좌표만 변경하면 애니메이션이 제대로 작동한다.
 하지만 width나 height를 0.01이라도 변경하면 전혀 예상치못한 동작이 발생한다.
 -> TODO: FIXME: ... 방향도 원하는 방향이 아니고, 이상하다. 그리고 completion에 크기 바꿔놓아도 초기 layoutConstraints값으로 돌아간다.
 
 center와 frame의 x,y 조작은 둘다 같은 CGPoint type이기에 혼합도 가능하고, 애니메이션 동작도 유사하다.
 */

/*
 let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
     self.backgroundImage.frame.size = CGSize(
         width: self.width*CGFloat(self.isBig ? 2 : 1),
         height: self.height*CGFloat(self.isBig ? 2 : 1)
     )
     self.label.frame = CGRect(
         x: self.backgroundImage.frame.minX + self.backgroundImage.frame.width / 4,
         y: self.backgroundImage.frame.minY + self.backgroundImage.frame.width / 4,
         width: self.backgroundImage.frame.width / 3,
         height: self.backgroundImage.frame.width / 3)
     self.backgroundImage.frame.origin = CGPoint(
         x: <#T##CGFloat#>,
         y: <#T##CGFloat#>
     )
 }
 animator.startAnimation()
}
 */
