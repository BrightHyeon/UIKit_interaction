//
//  MaskViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import UIKit
import SwiftUI


class AngryViewController: UIViewController {
    
    private var currentIndex: Int = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.setShadows()
            })
        }
    }
    
    // data
    private var memos: [Memo] = [
        Memo(memoRatio: [8, 6], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [1.8, 5.5], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [3, 2.5], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [8, 1.6], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [1.8, 1.5], memoAnimal: "tigerMemo")
    ]
    
    private var buttons: [UIButton] = []
    
    // mask layer animation 담당
    private let maskLayer = CAShapeLayer()
    
    // 배경이미지
    private let backImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // 취소 버튼
    private lazy var xButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusIndex), for: .touchUpInside)
        return button
    }()
    
    private func memoButton(_ memo: Memo) -> UIButton {
        let button = UIButton(frame: memo.memoFrame)
        button.setImage(UIImage(named: memo.memoAnimal), for: .normal)
        return button
    }
    
    private let blackView: UIView = {
        let uiView = UIView(frame: UIScreen.main.bounds)
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return uiView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(backImageView)
        
        for (idx, i) in memos.enumerated().reversed() { // .enumeratad.reversed 순서 중요. 이렇게 해야 index도 거꾸로 들어옴.
            let button = memoButton(i)
            button.tag = idx // tag는 순서대로 잘 달린다. cause reversed()
            button.addTarget(self, action: #selector(zoomInAction(_:)), for: .touchUpInside)
            buttons.append(button)
            backImageView.addSubview(button)
        }
        
        setShadows()
        
        view.addSubview(xButton)
        view.addSubview(plusButton)
    }
    
    func setShadows() { //각 memo의 outMaskLayers 추가.
        let path = UIBezierPath(rect: view.bounds)
        for memo in memos[0...currentIndex] {
            path.append(memo.outMaskLayer)
        }
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        blackView.layer.mask = maskLayer
        // 자동으로 중복없음. 기존 위치에서 새로운 위치로 업데이트된다.
        backImageView.insertSubview(blackView, at: memos.count - currentIndex - 1)
    }
    
    @objc func zoomInAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            Zoom.status = .zoomIn

            self.backImageView.frame = self.memos[sender.tag].backImageFrame //
            self.blackView.frame = self.backImageView.bounds //frame 할당하면 안되다가 bounds주니까 되네...?
            print("backImageView's frame: \(self.backImageView.frame)")
            print("blackView's frame: \(self.blackView.frame)")

            let _ = self.buttons.map { button in
                button.frame = self.memos[button.tag].memoFrame
            }
        }
        self.zoomInAnimate(tag: sender.tag)
    }
    
    deinit {
        print("deinit")
    }
    
    func zoomInAnimate(tag: Int) {
//        let path = memos[tag].backPathFrame
        let path = UIBezierPath(rect: self.backImageView.bounds)
        for memo in memos[0...currentIndex] {
            path.append(memo.inMaskLayer)
        }
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = self.maskLayer.path
        animation.toValue = path.cgPath
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: nil)
        DispatchQueue.main.async {
            self.maskLayer.path = path.cgPath
        }
    }
//
    @objc func zoomOutAction() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }

            Zoom.status = .zoomOut

            self.backImageView.frame = UIScreen.main.bounds
            self.blackView.frame = self.backImageView.bounds
            print("backImageView's frame: \(self.backImageView.frame)")
            print("blackView's frame: \(self.blackView.frame)")

            let _ = self.buttons.map { button in
                button.frame = self.memos[button.tag].memoFrame
            }
        }
        self.animate2()
    }

    func animate2() {
        let path = UIBezierPath(rect: view.bounds)
        for memo in memos[0...currentIndex] {
            path.append(memo.outMaskLayer)
        }
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = self.maskLayer.path
        animation.toValue = path.cgPath
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.maskLayer.add(animation, forKey: nil)
        DispatchQueue.main.async {
            self.maskLayer.path = path.cgPath
        }
    }
    
    @objc func plusIndex() {
        self.currentIndex += 1
    }
}

enum Zoom {
    case zoomIn
    case zoomOut
    
    static var status: Zoom = .zoomOut // singleton
}

struct Memo {
    var isZoomMode: Bool {
        if Zoom.status == .zoomIn {
            return true
        } else {
            return false
        }
    }
    
    var memoRatio: [CGFloat]
    var memoAnimal: String
    
    var memoFrame: CGRect {
        let mul = isZoomMode ? 2.0 : 1.0
        return CGRect(
            origin: CGPoint(
                x: .screenW * mul / memoRatio[0],
                y: .screenH * mul / memoRatio[1]),
            size: isZoomMode ? .memoDoubleSize : .memoSize
        )
    }
    
    var backImageFrame: CGRect { // 확대 시 배경 corkboard 크기
        return CGRect(
            origin: CGPoint(
                x: -.screenW*2 / memoRatio[0] + .screenW/5,
                y: -.screenH*2 / memoRatio[1] + .screenH/3
            ),
            size: .backDoubleSize
        )
    }
    
    var backPathFrame: UIBezierPath { // 확대 시 배경 path 크기
        return UIBezierPath(
            rect: CGRect(
                origin: CGPoint(
                    x: -.screenW*2 / memoRatio[0] + .screenW/5,
                    y: -.screenH*2 / memoRatio[1] + .screenH/3
                ),
                size: .backDoubleSize
            )
        )
    }
    
    var outMaskLayer: UIBezierPath { // 축소 시 memo mask 크기
        return UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: .screenW / memoRatio[0] - 25,
                    y: .screenH / memoRatio[1] - 25
                ),
                size: .maskSize
            )
        )
    }
    
    var inMaskLayer: UIBezierPath { // 확대 시 memo mask 크기
        return UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: .screenW * 2 / memoRatio[0] - 50,
                    y: .screenH * 2 / memoRatio[1] - 50
                ),
                size: .maskDoubleSize
            )
        )
    }
}

extension CGSize {
    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
        
    static let memoSize = CGSize(width: 100, height: 100)
    
    static let memoDoubleSize = CGSize(width: 200, height: 200)
    
    static let maskSize = CGSize(width: 150, height: 150)
    
    static let maskDoubleSize = CGSize(width: 300, height: 300)
}
