//
//  FadingBGViewController.swift
//  fadingBGPagingView
//
//  Created by Cedan 7EDGE on 7/11/19.
//  Copyright © 2019 cedanmisquith. All rights reserved.
//

import UIKit

class FadingBGViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!

    var colors: [UIColor] = [.red, .orange, .yellow, .blue, .green]
    var bgImageView = [UIImageView]()
    var bgTitleLabel = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.width
        let height = self.view.frame.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = .clear
        self.view.addSubview(scrollView)
      
        var index: Int = 1
        for color in colors{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            imageView.image = getImageWithColor(color: color, size: CGSize(width: width, height: height))
            bgImageView.append(imageView)
            view.insertSubview(imageView, belowSubview: scrollView)
            
            let label = UILabel(frame: CGRect(x: 0, y: self.view.frame.height/2-25, width: self.view.frame.width, height: 50))
            label.textColor = .white
            label.textAlignment = .center
            label.font = label.font.withSize(28)
            label.adjustsFontSizeToFitWidth = true
            label.text = "BACKGROUND \(index)"
            bgTitleLabel.append(label)
            view.insertSubview(label, belowSubview: scrollView)
            
            index += 1
        }
        scrollView.contentSize = CGSize(width: width*CGFloat(colors.count), height: height)
        animateOnScroll()
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animateOnScroll()
    }
    
    func animateOnScroll() {
        let width: CGFloat = scrollView.frame.size.width
        let page = Int(((scrollView.contentOffset.x + (0.5 * width)) / width))
        print(page)
        let viewWidth = self.view.frame.width
        if page == bgImageView.count{
            print("Print Invalid Page")
        }else{
            for (index, view) in bgImageView.enumerated() {
                view.alpha = (scrollView.contentOffset.x-(CGFloat(index-1)*viewWidth))/viewWidth
                bgTitleLabel[index].alpha = (scrollView.contentOffset.x-(CGFloat(index-1)*viewWidth))/viewWidth
            }
        }
    }
}
