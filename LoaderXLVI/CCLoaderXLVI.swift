//
//  LoaderXLVI.swift
//  LoaderXLVI
//
//  Created by Amir REZVANI on 5/29/19.
//  Copyright © 2019 Amir REZVANI. All rights reserved.
//

import UIKit

public class CCLoaderXLVI {
    
    private var loaderView: CCSquareLoader?
    private(set) public var isEnabled = false
    
    func startLoaderIn(_ view: UIView) {
        if let loaderView = self.loaderView, view.subviews.contains(loaderView) {
            return
        }
        
        let side = min(view.bounds.width/5.0, view.bounds.height/5.0)
        loaderView = CCSquareLoader(frame: .zero, squareBorderwidth: side/7.0)
        loaderView!.frame = CGRect(x: 0, y: 0, width: side, height: side)
        loaderView!.center = CGPoint(x: view.bounds.width/2.0,
                                       y: view.bounds.height/2.0)
        view.addSubview(loaderView!)
        loaderView!.beginLoader()
        isEnabled = true
    }
    
    func stopLoader() {
        guard let loaderView = self.loaderView else {
            return
        }
        loaderView.stopLoader()
        loaderView.removeFromSuperview()
        isEnabled = false
    }
}
