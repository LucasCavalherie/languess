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
    
    let nextButton = UIButton()
    let titleLabel = UILabel()
    let recordLabel = UILabel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var record = (UserDefaults.standard.value(forKey: "highScore") != nil) ? UserDefaults.standard.value(forKey: "highScore") : 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.set(0, forKey: "highScore")
        
        setupTitle()
        setupRecord()
        setupButton()
        setupSubscriptions()
        
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
        titleLabel.textColor = .label
        
        // Autolayout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    func setupRecord() {
        // Add subview
        view.addSubview(recordLabel)
        
        // Style
        recordLabel.text = "Seu recorde: \(RecordController.shared.record.value)"
        recordLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        recordLabel.textAlignment = .center
        recordLabel.textColor = .label
        
        // Autolayout
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
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
        nextButton.setTitleColor(.label, for: .normal)
        
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
            nextButton.topAnchor.constraint(equalTo: recordLabel.bottomAnchor, constant: 200),
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
        recordLabel.text = "Seu recorde: \(newRecord)"
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

