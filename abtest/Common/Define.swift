//
//  Define.swift
//  switchwon
//
//  Created by sangdon kim on 2022/07/06.
//  Copyright © 2022 Switchwon. All rights reserved.
//

import UIKit

//============================================================
// MARK: - Data Define
//============================================================

/// 유저 디폴트
public var USER_DEFAULT : UserDefaults { get { return UserDefaults.standard } }


/// 디바이스 Identifier
public var DEVICE_Identifier: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
}

public var DEVICE_UUID: String {
    get {
        if let strUUID = USER_DEFAULT.string(forKey: "UUID") {
            return strUUID
        } else if let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) {
            USER_DEFAULT.setValue(String(uuid), forKey: "UUID")
            return String(uuid)
        } else {
            return ""
        }
    }
}

/// 공통 앱델리게이트 호출
/// - Returns: 공통 앱델리게이트
func GET_APPDELEGATE() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

/// Info 번들 정보
/// - Parameter strKey: Key
/// - Returns: Value
func BundleInfo(strKey: String) -> String? {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
        let dicInfo = NSDictionary.init(contentsOfFile: path)
        return dicInfo?[strKey] as? String
    }
    return nil
}

//============================================================
// MARK: - User Default Define
//============================================================

/// APNS TOKEN
public var APNS_TOKEN: String {
    get { return USER_DEFAULT.string(forKey: "APNS_TOKEN") ?? "" }
    set { USER_DEFAULT.setValue(newValue, forKey: "APNS_TOKEN") }
}

/// APNS TOKEN
public var FCM_TOKEN: String {
    get { return USER_DEFAULT.string(forKey: "FCM_TOKEN") ?? "" }
    set { USER_DEFAULT.setValue(newValue, forKey: "FCM_TOKEN") }
}

//============================================================
// MARK: - Setting Define
//============================================================


//============================================================
// MARK: - UI Define
//============================================================

/// DEFINE : 스크린 BOUNDS
let ScreenBounds : CGRect = UIScreen.main.bounds
/// DEFINE : 스크린 WIDTH
let ScreenWidth :CGFloat = UIScreen.main.bounds.width
/// DEFINE : 스크린 HEIGHT
let ScreenHeight :CGFloat = UIScreen.main.bounds.height
/// DEFINE : 노치 디스플레이 여부
var IS_NOTCH : Bool { get { if 812...926 ~= ScreenHeight { return true } else { return false } } }

