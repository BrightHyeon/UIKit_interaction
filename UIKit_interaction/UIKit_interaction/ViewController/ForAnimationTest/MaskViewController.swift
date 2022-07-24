////
////  MaskViewController.swift
////  UIKit_interaction
////
////  Created by Hyeonsoo Kim on 2022/07/23.
////
//
//import UIKit
//import CoreFoundation
//
//
//class MaskViewController: UIViewController {
//
//    private var memo = Memo(memoRatio: [8, 6], memoAnimal: "tigerMemo")
//
//    private var memos: [Memo] = [
//        Memo(memoRatio: [8, 6], memoAnimal: "tigerMemo"),
//        Memo(memoRatio: [1.8, 5.5], memoAnimal: "tigerMemo")
//    ]
//
//    private var maskLayer = CAShapeLayer()
//
//    private let backImageView: UIImageView = {
//        let imageView = UIImageView(frame: UIScreen.main.bounds)
//        imageView.image = UIImage(named: "mainBackground")
//        imageView.contentMode = .scaleToFill
//        imageView.isUserInteractionEnabled = true
//        return imageView
//    }()
//
//    private lazy var xButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
//        button.setImage(UIImage(systemName: "xmark"), for: .normal)
//        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
//        return button
//    }()
//
//    func memoButton(_ memo: Memo) -> UIButton {
//        let button = UIButton(frame: memo.memoFrame)
//        button.setImage(UIImage(named: memo.memoAnimal), for: .normal)
//        return button
//    }
//
//    var buttons: [UIButton] = []
//
//    private lazy var blackView: UIView = {
//        let uiView = UIView(frame: UIScreen.main.bounds)
//        uiView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
//        return uiView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .systemBackground
//
//        view.addSubview(backImageView)
//        backImageView.addSubview(blackView)
//
//        for (idx, i) in memos.enumerated() {
//            let button = memoButton(i)
//            button.tag = idx
//            button.addTarget(self, action: #selector(zoomInAction(_:)), for: .touchUpInside)
//            buttons.append(button)
//            backImageView.addSubview(button)
//        }
//
//        view.addSubview(xButton)
//
//        make()
//    }
//
//    @objc func zoomInAction(_ sender: UIButton) {
//        print("호출")
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
//            guard let self = self else { return }
//
//            Zoom.status = .zoomIn
//
//            self.backImageView.frame = self.memos[sender.tag].backImageFrame
//            self.blackView.frame = self.backImageView.frame
//            self.blackView.layoutIfNeeded()
//            print("backImageView's frame: \(self.backImageView.frame)")
//            print("blackView's frame: \(self.blackView.frame)")
//
//            let _ = self.buttons.map { button in
//                button.frame = self.memos[button.tag].memoFrame
//            }
//        }
//        self.animate()
//    }
//
//    @objc func zoomOutAction() {
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
//            guard let self = self else { return }
//
//            Zoom.status = .zoomOut
//
//            self.backImageView.frame = self.memos[1].backImageFrame
//            self.blackView.frame = self.backImageView.frame
//            print("backImageView's frame: \(self.backImageView.frame)")
//            print("blackView's frame: \(self.blackView.frame)")
//
//            let _ = self.buttons.map { button in
//                button.frame = self.memos[button.tag].memoFrame
//            }
//        }
//        self.animate2()
//    }
//
//    func make() {
//        for i in memos {
//            let path = UIBezierPath
//        }
//
//        layers[idx] = i.outMaskLayer
//        blackView.layer.mask = layers[1]
////        backImageView.insertSubview(blackView, at: 0)
//    }
//
//    func animate() {
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = memo.outMaskLayer.path
//        animation.toValue = memo.inMaskLayer.path
//        animation.duration = 1.0
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        maskLayer.add(animation, forKey: nil)
//        DispatchQueue.main.async {
////            self.blackView.layer.mask = self.memo.inMaskLayer
//            self.maskLayer.path = self.memo.inMaskLayer.path
//        }
//    }
//
//    var maskLayer = CAShapeLayer()
//
//    func animate2() {
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = memo.inMaskLayer.path
//        animation.toValue = memo.outMaskLayer.path
//        animation.duration = 1.0
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        maskLayer.add(animation, forKey: nil)
//        DispatchQueue.main.async {
////            self.blackView.layer.mask = self.memo.outMaskLayer
//            self.maskLayer.path = self.memo.outMaskLayer.path
//        }
//    }
//}
//
//enum Zoom {
//    case zoomIn
//    case zoomOut
//
//    static var status: Zoom = .zoomOut
//}
//
//struct Memo {
//    var isZoomMode: Bool {
//        if Zoom.status == .zoomIn {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    var memoRatio: [CGFloat]
//    var memoAnimal: String
//
//    var backImageFrame: CGRect {
//        if isZoomMode {
//            return CGRect(
//                origin: CGPoint(
//                    x: -.screenW*2 / memoRatio[0] + .screenW/5,
//                    y: -.screenH*2 / memoRatio[1] + .screenH/3
//                ),
//                size: .backDoubleSize
//            )
//        } else {
//            return UIScreen.main.bounds
//        }
//    }
//
//    var memoFrame: CGRect {
//        let mul = isZoomMode ? 2.0 : 1.0
//        return CGRect(
//            origin: CGPoint(
//                x: .screenW * mul / memoRatio[0],
//                y: .screenH * mul / memoRatio[1]),
//            size: isZoomMode ? .memoDoubleSize : .memoSize
//        )
//    }
//
//    var outMaskLayer: UIBezierPath {
//        let path = UIBezierPath(
//            ovalIn: CGRect(
//                origin: CGPoint(
//                    x: .screenW / memoRatio[0] - 25,
//                    y: .screenH / memoRatio[1] - 25
//                ),
//                size: .maskSize
//            )
//        )
//        let path = UIBezierPath(rect: UIScreen.main.bounds)
//        path.append(UIBezierPath(
//            ovalIn: CGRect(
//                origin: CGPoint(
//                    x: .screenW / memoRatio[0] - 25,
//                    y: .screenH / memoRatio[1] - 25
//                ),
//                size: .maskSize
//            )
//        ))
////        maskLayer.path = path.cgPath
////        maskLayer.fillRule = .evenOdd
//        return path
//    }
//
//    var inMaskLayer: UIBezierPath {
//        let path = UIBezierPath(
//            rect: CGRect(
//                origin: CGPoint(
//                    x: -.screenW*2 / memoRatio[0] + .screenW/5,
//                    y: -.screenH*2 / memoRatio[1] + .screenH/3
//                ),
//                size: .backDoubleSize
//            )
//        )
//        path.append(UIBezierPath(
//            ovalIn: CGRect(
//                origin: CGPoint(
//                    x: .screenW * 2 / memoRatio[0] - 50,
//                    y: .screenH * 2 / memoRatio[1] - 50
//                ),
//                size: .maskDoubleSize
//            )
//        ))
////        maskLayer.path = path.cgPath
////        maskLayer.fillRule = .evenOdd
//        return path
//    }
//}
//
//extension CGSize {
//    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
//
//    static let memoSize = CGSize(width: 100, height: 100)
//
//    static let memoDoubleSize = CGSize(width: 200, height: 200)
//
//    static let maskSize = CGSize(width: 150, height: 150)
//
//    static let maskDoubleSize = CGSize(width: 300, height: 300)
//}
