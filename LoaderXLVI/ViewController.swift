//
//  ViewController.swift
//  LoaderXLVI
//
//  Created by Amir REZVANI on 5/28/19.
//  Copyright © 2019 Amir REZVANI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var button: UIButton!
    var loader = LoaderXLVI()
    let buttonTitles = ["Start Loader", "Stop Loader"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        button = UIButton(frame: .zero)
        button.setTitle(buttonTitles[0], for: .normal)
        button.addTarget(self, action: #selector(startLoader), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.sizeToFit()
        button.center = CGPoint(x: view.bounds.width/2.0,
                                y: view.safeAreaLayoutGuide.layoutFrame.size.height - button.frame.height/2.0)
    }
    
    // MARK: - private
    
    @objc private func startLoader(_ sender: Any) {
        loader.isEnabled ? loader.stopLoader() : loader.startLoaderIn(view)
        button.setTitle(buttonTitles[(loader.isEnabled ? 1 : 0)], for: .normal)
    }
    
}

