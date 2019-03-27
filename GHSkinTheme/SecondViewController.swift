//
//  SecondViewController.swift
//  GHSkinTheme
//
//  Created by Sansi Mac on 2019/2/22.
//  Copyright © 2019 gh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, GHThemeProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
        addThemeObserver()
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        btn.setTitle("changeTheme", for: .normal)
        btn.addTarget(self, action: #selector(changeThemeAction), for: .touchUpInside)
        return btn
    }()

    @objc func changeThemeAction() {
        let obj = UserDefaults.standard.bool(forKey: kThemeStyle)
        UserDefaults.standard.set(!obj, forKey: kThemeStyle)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .updateTheme, object: nil)
    }

    override func ghUpdateTheme() {
        super.ghUpdateTheme()
        changeTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.once(token: className) {
            changeTheme()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.remoceOnce(token: className)
    }
    
    func changeTheme() {
        if GHThemeManager.shared.themeStyle == .day {
            view.backgroundColor = .blue
            btn.backgroundColor = .orange
        }else{
            view.backgroundColor = .red
            btn.backgroundColor = .yellow
        }
    }
    
    
    deinit {
        print("=========== deinit: \(self.classForCoder)")
        removeThemeObserver()
    }
    
}

