//
//  ViewController.swift
//  SwiftYoutuberApp01
//
//  Created by 中塚富士雄 on 2020/09/07.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import SegementSlide


class ViewController: SegementSlideDefaultViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        defaultSelectedIndex = 0
        
    }

    override func segementSlideHeaderView() -> UIView{
        
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named:"header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeght: CGFloat
        if #available(iOS 11.0, *){
            headerHeght = view.bounds.height/4+view.safeAreaInsets.top
        }else{
            headerHeght = view.bounds.height/4+topLayoutGuide.length
       }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeght).isActive = true
        return headerView
        
        
    }
    
    override var titlesInSwitcher: [String]{
 
//        return ["ナラティブブック","COVID-19","Alzheimer's","remote care","telemedicine","guardianship"]
        
        return ["乃木坂46","欅坂46","日向坂46","iZ*one","twice","rocket girls 101"]
        
 
    }
    
    override func segementSlideContentViewController(at index:Int) -> SegementSlideContentScrollViewDelegate?{
        
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page6ViewController()
            
        default:
            return Page1ViewController()
        }
        
        
        
        
    }
    
    

}

