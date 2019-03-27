
//
//  GHThemeManager.swift
//  GHSkinTheme
//
//  Created by Sansi Mac on 2019/2/22.
//  Copyright © 2019 gh. All rights reserved.
//

import Foundation
import UIKit


protocol GHThemeProtocol {
}
extension GHThemeProtocol where Self: UIView {
    func addThemeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ghUpdateTheme), name: .updateTheme, object: nil)
    }
    func removeThemeObserver() {
        NotificationCenter.default.removeObserver(self, name: .removeTheme, object: nil)
    }
}
extension GHThemeProtocol where Self: UIViewController {
    func addThemeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ghUpdateTheme), name: .updateTheme, object: nil)
    }
    func removeThemeObserver() {
        NotificationCenter.default.removeObserver(self, name: .removeTheme, object: nil)
    }
}



extension NSNotification.Name {
    static let updateTheme = NSNotification.Name(rawValue: "updateTheme")
    static let removeTheme = NSNotification.Name(rawValue: "removeTheme")
}
extension UIView {
    @objc func ghUpdateTheme() {
        
    }
}
extension UIViewController {
    @objc func ghUpdateTheme() {
        
    }
}



protocol ClassNameProtocol {
}
extension ClassNameProtocol where Self: UIView {
    var className: String {
        return "\(self.classForCoder)"
    }
}
extension ClassNameProtocol where Self: UIViewController {
    var className: String {
        return "\(self.classForCoder)"
    }
}
extension UIView: ClassNameProtocol{
}
extension UIViewController: ClassNameProtocol{
}


let kThemeStyle = "GHThemeStyle"


extension DispatchQueue {
    fileprivate static var _onceToken = [String]()
    static func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }
    static func remoceOnce(token: String) {
        if _onceToken.contains(token) {
            _onceToken.removeAll { (value) -> Bool in
                return value == token
            }
        }
    }
}


//MARK: - GHThemeManager
enum ThemeStyle {
    case day
    case night
}
class GHThemeManager {
    static let shared = GHThemeManager.init()
    var themeStyle: ThemeStyle {
        if UserDefaults.standard.bool(forKey: kThemeStyle) {
            return ThemeStyle.day
        }
        return ThemeStyle.night
    }
    
    private init() {
    }
}
