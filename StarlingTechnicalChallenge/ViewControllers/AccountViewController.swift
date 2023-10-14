//
//  ViewController.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    private enum Constants {
        static let animationCycle: Double = 3
    }
    
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var roundUpContentView: UIView!
    @IBOutlet private weak var roundUpAmountLabel: UILabel!
    @IBOutlet private weak var transferRoundUpButton: UIButton!
    
    // TODO: Inject if we perform testing on UI
    private let viewModel = AccountViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundUpContentView.isHidden = true
        styleTransferButton()
        
        animateCycle(scaleDown: true)
        
        viewModel.delegate = self
        viewModel.retrieveRoundUpAmount()
    }
    
    @IBAction private func moveRoundUpToSavings() {
        
    }

    // Simple animation if loading takes longer, transitioning smoothly from Start Screen
    private func animateCycle(scaleDown: Bool) {
        UIView.animate(withDuration: Constants.animationCycle) { [weak self] in
            self?.logoImage.transform = scaleDown ? CGAffineTransform(scaleX: 0.01, y: 0.01) : .identity
        } completion: { [weak self] completed in
            guard self?.viewModel.isLoading == true else {
                self?.logoImage.isHidden = true
                return
            }
            guard completed else { return }
            self?.animateCycle(scaleDown: !scaleDown)
        }
    }
    
    private func styleTransferButton() {
        transferRoundUpButton.layer.cornerRadius = 8
        transferRoundUpButton.backgroundColor = .blue
        transferRoundUpButton.titleLabel?.textColor = UIColor.systemBackground
        transferRoundUpButton.setTitle("Add to savings now", for: .normal)
    }
}

extension AccountViewController: AccountViewModelDelegate {
    
    func receivedRoundUp(_ roundUpAmount: Int) {
        let attributedString = NSMutableAttributedString(string: "Great news!\nYou can now add\n")
        let boldString = NSMutableAttributedString(string: "\(roundUpAmount)",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        attributedString.append(boldString)
        attributedString.append(NSMutableAttributedString(string: " pence\nto your Savings Goal"))
        roundUpAmountLabel.attributedText = attributedString
        
        logoImage.isHidden = true
        roundUpContentView.isHidden = false
    }
    
}
