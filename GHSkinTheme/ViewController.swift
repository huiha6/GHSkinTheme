//
//  ViewController.swift
//  GHSkinTheme
//
//  Created by Sansi Mac on 2019/2/22.
//  Copyright © 2019 gh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GHThemeProtocol {

    @IBOutlet weak var pushBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addThemeObserver()

    }
    
    @IBAction func pushAction(_ sender: UIButton) {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
    func changeTheme() {
        if GHThemeManager.shared.themeStyle == .day {
            view.backgroundColor = .blue
            pushBtn.backgroundColor = .orange
        }else{
            view .backgroundColor = .red
            pushBtn.backgroundColor = .yellow
        }
    }
    
    
    func delay(_ time: TimeInterval, _ result:@escaping (()->Void)) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+time, execute: result)
    }
}


