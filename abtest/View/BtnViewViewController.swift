//
//  BtnViewViewController.swift
//  abtest
//
//  Created by PNX on 2022/10/05.
//

import UIKit
import FirebaseAnalytics
import FirebaseRemoteConfig
import SnapKit

class BtnViewViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
    }
    
    
    /// firebase A/B 테스트 기준으로 버튼 정의 // targetEnd
    func addButton() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfig.configSettings = remoteConfigSettings
        
        remoteConfig.fetch { (state, error) in
            if state == .success {
                remoteConfig.fetchAndActivate()
                
                let btnPositionRemote = remoteConfig.configValue(forKey: "button_position")
                guard let btnPosition = btnPositionRemote.stringValue else { return }
                
                DLog("addButton \(btnPosition)")
                let btn = UIButton()
                btn.setTitle("\(btnPosition) Btn", for: .normal)
                btn.setTitleColor(UIColor.init(hex: "#ffffff"), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                btn.backgroundColor = UIColor.init(hex: "#ff0000")
                self.view.addSubview(btn)
                if btnPosition == "bottom" {
                    btn.snp.makeConstraints { make in
                        make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
                        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                        make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
                        make.height.equalTo(40)
                    }
                } else {
                    btn.snp.makeConstraints { make in
                        make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
                        make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
                        make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
                        make.height.equalTo(40)
                    }
                }
                Analytics.setUserProperty(btnPosition, forName: "experimentGroup")
                Analytics.logEvent("buttonShown", parameters: nil)
                
                btn.addTarget {
                    let vc = TargetViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
}
