//
//  StartScreen.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import SwiftUI
import UIKit

class StartScreen: UIViewController {
    
    let nextButton = UIButton()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupButton()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupTitle() {
        // Add subview
        view.addSubview(titleLabel)
        
        // Style
        titleLabel.text = "Languess"
        titleLabel.font = UIFont.systemFont(ofSize: 64.0, weight: .thin)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        // Autolayout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    func setupButton() {
        // Subview
        view.addSubview(nextButton)
        
        // Style
        nextButton.configuration?.baseBackgroundColor = .systemBackground
        nextButton.configuration?.baseForegroundColor = .black
        
        nextButton.setTitle("Jogar", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        nextButton.setTitleColor(.black, for: .normal)
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.cornerRadius = 10.0
        
        // Target
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        // Layout automatico
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 300),
            nextButton.widthAnchor.constraint(equalToConstant: 300),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func goToNextScreen() {
        let nextScreen = QuizScene()
        nextScreen.title = "Quiz"
        navigationController?.pushViewController(nextScreen, animated: true)
    }


}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: StartScreen())
    }
}

