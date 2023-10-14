//
//  ViewController.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet private weak var logoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIView.animate(withDuration: 3) {
            self.logoImage.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        } completion: { completed in
            guard completed else { return }
            self.logoImage.isHidden = true
        }
        
    }


}

