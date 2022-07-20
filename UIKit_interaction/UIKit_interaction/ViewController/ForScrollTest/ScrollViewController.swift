//
//  ScrollViewController.swift
//  UIKit_interaction
//
//  Created by Hyeonsoo Kim on 2022/07/20.
//

import UIKit

class ScrollViewController: UIViewController {
    
    private let mainScroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label6: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label7: UILabel = {
        let label = UILabel()
        label.text = "Scroll Test"
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainScroll)
        
        mainScroll.addSubview(label1)
        mainScroll.addSubview(label2)
        mainScroll.addSubview(label3)
        mainScroll.addSubview(label4)
        mainScroll.addSubview(label5)
        mainScroll.addSubview(label6)
        mainScroll.addSubview(label7)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            //필수 3가지 ... MARK: frame보단 이렇게 constraints로 하는게 좀더 올바르고 dynamic하다.
            mainScroll.topAnchor.constraint(equalTo: view.topAnchor),
            mainScroll.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainScroll.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            label1.topAnchor.constraint(equalTo: mainScroll.topAnchor),
            label1.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label1.widthAnchor.constraint(equalToConstant: 370),
            label1.heightAnchor.constraint(equalToConstant: 200),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            label2.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label2.widthAnchor.constraint(equalToConstant: 370),
            label2.heightAnchor.constraint(equalToConstant: 200),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            label3.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label3.widthAnchor.constraint(equalToConstant: 370),
            label3.heightAnchor.constraint(equalToConstant: 200),
            
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            label4.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label4.widthAnchor.constraint(equalToConstant: 370),
            label4.heightAnchor.constraint(equalToConstant: 200),
            
            label5.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            label5.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label5.widthAnchor.constraint(equalToConstant: 370),
            label5.heightAnchor.constraint(equalToConstant: 200),
            
            label6.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            label6.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label6.widthAnchor.constraint(equalToConstant: 370),
            label6.heightAnchor.constraint(equalToConstant: 200),
            
            label7.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 20),
            label7.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor),
            label7.widthAnchor.constraint(equalToConstant: 370),
            label7.heightAnchor.constraint(equalToConstant: 200),
            //MARK: IMPORTANT - 이게 Real 핵심 keypoint이다. 마지막 요소의 bottom과 Scroll존의 bottom을 명시적으로 맞춰주는 것~!
            label7.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor, constant: -100)
            //MARK: 컴포넌트의 시작점(top)과 끝점(bottom)의 Anchor를 현재 속해있는 ScrollView와 잘 매칭시켜주는 것이 핵심이다.
        ])
    }
}

/*
 동작 이해가 잘 되지않는다.
 
 mainScroll.frame = view.bounds만 한 상태에서는 아예 스크롤이 안된다.
 
 반면 mainScroll.contentSize = view.bounds.size를 하면 스크롤이 되지만 끝까지 되지는 않는다.
 
 출처: https://stackoverflow.com/questions/28211989/what-is-the-difference-between-tableview-contentsize-and-tableview-frame-size
 예를 들어, 장치의 화면이 568(높이)이고 그 안에 UITableView100개의 셀과 각각의 높이가 50인 (모든 화면을 차지하는) 화면이 있다고 가정해 보겠습니다. My tableView.frame.size.height는 568과 같지만 tableView.contentSize.height모든 셀의 스크롤 크기와 같으므로 5000입니다.
 
 즉, contentSize는 스크롤 존의 크기같다.
 view.bounds와 view.bounds.size 는 결국 x,y 유무의 차이이지만
 어디에 이 값을 넣었느냐에 따라 스크롤 유무가 바뀐듯 하다.
 contentSize에 만약 height를 당장 700정도만 넣어도 스크롤이 잘 되질않는다.
 
 실제로 UILabel, UIButton 등에는 frame은 있지만, contentSize라는 프로퍼티가 없다.
 현재 확인한 결과로는 UITableView, UICollectionView, UIScrollView 등이 가지고 있는데 이 역시 원래 UIScrollView의 프로퍼티이고 나머지는 이를 상속하기에 사용가능한 것이다.
 
 하지만 우리의 스크롤 문제에선 이게 중요한 것은 아니다. 이건 단지 순간적으로 스크롤존이 커져서 조금이나마 스크롤이 된 것 뿐이다.
 키포인트는 top과 bottom을 컴포넌트와 명시적으로 constraints를 매칭시켜주는 것이다.
 
 Young 멘토가 말씀하시길,
 frame은 get 용도로 쓰는 것이 좋고, set으로 쓰는 것은 지양하는 것이 좋다고하신다.
 
 width, height는 constraints로 동적으로 정해주는 것이 좋아보인다.
 */
