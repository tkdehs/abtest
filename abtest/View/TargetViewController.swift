//
//  TargetViewController.swift
//  abtest
//
//  Created by PNX on 2022/10/05.
//

import UIKit
import FirebaseAnalytics
import SnapKit

class TargetViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("targetEnd", parameters: nil)
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.init(hex: "#000000")
        label.text = "Target ViewController"
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
}
