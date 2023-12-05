//
//  StartScreen.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import SwiftUI
import Combine
import UIKit

class StartScreen: UIViewController {
    
    let logo = UIImageView(image: UIImage(named: "Logo"))
    let nextButton = UIButton()
    let titleLabel = UILabel()
    let recordTitleLabel = UILabel()
    let recordLabel = UILabel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var record = (UserDefaults.standard.value(forKey: "highScore") != nil) ? UserDefaults.standard.value(forKey: "highScore") : 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.set(0, forKey: "highScore")
        
        setupLogo()
        setupTitle()
        setupRecord()
        setupButton()
        setupSubscriptions()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupLogo() {
        // Add subview
        logo.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(logo)
        
        // Autolayout
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4), // Largura
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor) // Altura igual à largura
                    
        ])
    }
    
    func setupTitle() {
        // Add subview
        view.addSubview(titleLabel)
        
        // Style
        titleLabel.text = "Languess"
        titleLabel.font = UIFont.systemFont(ofSize: 64.0, weight: .thin)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        
        // Autolayout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50)
        ])
    }
    
    func setupRecord() {
        // Add subview
        view.addSubview(recordTitleLabel)
        view.addSubview(recordLabel)
        
        // Style
        recordTitleLabel.text = "Seu recorde:"
        recordTitleLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        recordTitleLabel.textAlignment = .center
        recordTitleLabel.textColor = .label
        
        recordLabel.text = "\(RecordController.shared.record.value)"
        recordLabel.font = UIFont.systemFont(ofSize: 48.0, weight: .thin)
        recordLabel.textAlignment = .center
        recordLabel.textColor = .label
        
        // Autolayout
        recordTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            recordTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 75),
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.topAnchor.constraint(equalTo: recordTitleLabel.bottomAnchor, constant: 10),
        ])
    }
    
    func setupButton() {
        // Subview
        view.addSubview(nextButton)
        
        // Style
        nextButton.backgroundColor = UIColor.label
        
        nextButton.setTitle("Jogar", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        nextButton.setTitleColor(.systemBackground, for: .normal)
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.systemGray.cgColor
        nextButton.layer.cornerRadius = 10.0
        
        // Target
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        // Layout automatico
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            nextButton.widthAnchor.constraint(equalToConstant: 300),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func goToNextScreen() {
        let nextScreen = QuizScene()
        nextScreen.title = "Quiz"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    private func updateRecord(_ newRecord: Int) {
        recordLabel.text = "\(newRecord)"
    }
        
    private func setupSubscriptions() {
        RecordController.shared.record
            .sink {
                self.updateRecord($0) // executa quando há alguma mudança
            }
            .store(in: &cancellables)
    }


}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: StartScreen())
    }
}

