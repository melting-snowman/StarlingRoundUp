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
        viewModel.startMovingRoundUp()
    }

    // Simple animation if loading takes longer, transitioning smoothly from Start Screen
    private func animateCycle(scaleDown: Bool) {
        UIView.animate(withDuration: Constants.animationCycle) { [weak self] in
            self?.logoImage.transform = scaleDown ? CGAffineTransform(scaleX: 0.01, y: 0.01) : .identity
        } completion: { [weak self] completed in
            guard self?.roundUpContentView.isHidden == true else {
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
    
    func showLoadingScreen() {
        logoImage.isHidden = false
        roundUpContentView.isHidden = true
        
        animateCycle(scaleDown: true)
    }
    
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
    
    func receivedOutcome(_ outcome: AccountViewModelOutcome) {
        let title = "Thank you for joining us on this experience"
        let message: String
        switch outcome {
        case .noConfiguredSavingAccount:
            message = "We have found you currently do not have a Savings Goal setup. Our app doesn't currently support setting up saving goals, so please use our website temporarily to create one. We apologise for the inconvenience"
        case .transferInTheNextVersion:
            message = "You do have Savings Goals setup and we can't wait to help you save and achieve our dreams. Unfortunately in this version we haven't quite been ready to enable transfers via the app. Keep an eye on our next version"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let restartAction = UIAlertAction(title: "Restart", style: .cancel) { [weak self] _ in
            alertController.dismiss(animated: true)
            self?.viewModel.retrieveRoundUpAmount()
        }
        alertController.addAction(restartAction)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive) { _ in
            fatalError("Sorry, you asked for it :/. Rest assured that before Production we would invest more time and avoid ending this way")
        }
        alertController.addAction(quitAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
