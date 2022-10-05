//
//  Util_String.swift
//  CodeAble
//
//  Created by sangdon kim on 2022/07/06.
//  Copyright © 2022 Switchwon. All rights reserved.
//

import UIKit

extension String {
    /// 문자열 존재 여부
    var isExist : Bool { return !self.isEmpty }
    /// 문자열 길이
    var length: Int { get { return self.count } }
    /// 문자열 길이 ( UTF16 인코딩 길이 )
    var utf16Length: Int { get { return self.utf16.count } }
    
    /// Int Value
    var intValue : Int { get { return (self as NSString).integerValue } }
    /// CGFloat Value
    var floatValue : CGFloat { get { return CGFloat.init((self as NSString).floatValue) } }
    /// URL Value
    var urlValue: URL? { get { return URL(string: self) } }
    /// Bool Value
    var boolValue: Bool { get { return ["True","TRUE","true","t","YES","yes","Y","y","1"].contains(self) } }
    /// double Value
    var doubleValue : Double { get { return Double(self.replacingOccurrences(of: ",", with: "")) ?? 0.0 } }
    /// decimal Value
    var decimalValue : NSDecimalNumber { get { return NSDecimalNumber(string: self.replacingOccurrences(of: ",", with: "")) } }
    
    
    /// 정규식 체크
    func checkString(strRegex:String = "[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\\s]") -> Bool {
        let regex = try! NSRegularExpression(pattern: strRegex, options: [])
        let list = regex.matches(in:self, options: [], range:NSRange.init(location: 0, length:self.count))
        if list.count != self.count { return false }
        else { return true }
    }
    
    //============================================================
    // MARK: - UI Setting
    //============================================================
    
    /// 라벨 높이 계산
    func height(constraintedWidth width: CGFloat, font: UIFont, lineBreakMode : NSLineBreakMode = .byTruncatingTail, nLineCount : Int = 0) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.font = font
        label.numberOfLines = nLineCount
        label.text = self
        label.lineBreakMode = lineBreakMode
        label.sizeToFit()
        
        return label.frame.height
    }
    
    //============================================================
    // MARK: - String Subscript
    //============================================================
    
    subscript (i: Int) -> Character {
        if self.length > i {
            return self[self.index(self.startIndex, offsetBy: i)]
        } else {
            return Character.init("")
        }
    }
    
    subscript (i: Int) -> String {
        if self.length > i {
            return String(self[i] as Character)
        } else {
            return ""
        }
    }
    
    //============================================================
    // MARK: - Log String
    //============================================================

    /// 로그 정렬
    mutating func arrangeLogSpace( nCountAlign : Int = 65 ) {
        let nSpace : Int = nCountAlign - self.countLogStringWidth()
        if nSpace <= 0 { return }
        for _ in 0..<nSpace {
            self = self.appending(" ")
        }
    }

    mutating func appendTapSpace(nCount : Int ) {
        for _ in 1...nCount {
            self = self.appending("\t\t")
        }
    }

    /// 로그 문자 넓이 계산
    func countLogStringWidth() -> Int {
        var nCount : Int = 0
        
        for nIndex in 0..<self.length {
            let str : String = self[nIndex]
            if str.checkString(strRegex: "[가-힣ㄱ-ㅎㅏ-ㅣ]") == true {
                nCount = nCount + 2
            } else {
                nCount = nCount + 1
            }
        }
        
        return nCount
    }
}

extension String.Encoding {
    /// EUC_KR Encoding
    static let eucKrDecode = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
}
