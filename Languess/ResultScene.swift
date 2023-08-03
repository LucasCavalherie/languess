//
//  ResultScene.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import UIKit
import SwiftUI

class ResultScene: UIViewController {

    let firstButton = UIButton()
    
    var totalLabel = UILabel()
    
    var correctLabel = UILabel()
    var correctCount: Int = 0
    
    var wrongLabel = UILabel()
    var wrongCount: Int = 0
    
    var resultData: [ResultData] = [
        ResultData(word: "Palavra", correct: true),
        ResultData(word: "Palavra1", correct: true),
        ResultData(word: "Palavra2", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let record = (UserDefaults.standard.value(forKey: "highScore") != nil) ? UserDefaults.standard.value(forKey: "highScore") as! Int : 0
        if correctCount > record {
            UserDefaults.standard.set(correctCount, forKey: "highScore")
            RecordController.updateRecord(newRecord: correctCount)
        }
        
        
        setupButton()
        setupTotalQuestions()
        setupCorrectQuestions()
        setupWrongQuestions()
        setupAnswers()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupButton() {
        // Subview
        view.addSubview(firstButton)
        
        // Style
        firstButton.configuration?.baseBackgroundColor = .systemBackground
        firstButton.configuration?.baseForegroundColor = .black
        
        firstButton.setTitle("Jogar", for: .normal)
        firstButton.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        firstButton.setTitleColor(.label, for: .normal)
        
        firstButton.layer.borderWidth = 1.0
        firstButton.layer.borderColor = UIColor.systemGray.cgColor
        firstButton.layer.cornerRadius = 10.0
        
        // Target
        firstButton.addTarget(self, action: #selector(goToFirstScreen), for: .touchUpInside)
        
        // Layout automatico
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            firstButton.widthAnchor.constraint(equalToConstant: 300),
            firstButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupTotalQuestions() {
        // Add subview
        view.addSubview(totalLabel)
        
        // Style
        totalLabel.text = "Total: \(correctCount + wrongCount)"
        totalLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        totalLabel.textAlignment = .center
        totalLabel.textColor = .label
        
        // Autolayout
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func setupCorrectQuestions() {
        // Add subview
        view.addSubview(correctLabel)
        
        // Style
        correctLabel.text = "Acertos: \(correctCount)"
        correctLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        correctLabel.textAlignment = .center
        correctLabel.textColor = .label
        
        // Autolayout
        correctLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            correctLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            correctLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 50)
        ])
    }
    
    func setupWrongQuestions() {
        // Add subview
        view.addSubview(wrongLabel)
        
        // Style
        wrongLabel.text = "Erros: \(wrongCount)"
        wrongLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        wrongLabel.textAlignment = .center
        wrongLabel.textColor = .label
        
        // Autolayout
        wrongLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            wrongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wrongLabel.topAnchor.constraint(equalTo: correctLabel.bottomAnchor, constant: 50)
        ])
    }
    
    func setupAnswers() {
        var answersButtons: [UIButton] = []
        for i in 0..<resultData.count {
            let button = UIButton(type: .system)
            
            button.configuration?.baseBackgroundColor = .systemBackground
            button.configuration?.baseForegroundColor = .black
            button.setTitle(resultData[i].word, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
            button.setTitleColor(.label, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.systemGray.cgColor
            button.layer.cornerRadius = 10.0
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            answersButtons.append(button)
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    button.topAnchor.constraint(equalTo: wrongLabel.bottomAnchor, constant: 50)
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    button.topAnchor.constraint(equalTo: answersButtons[i-1].bottomAnchor, constant: 50)
                ])
            }
            
            
        }
    }
    
    @objc func goToFirstScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
}

struct ResultScene_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: ResultScene())
    }
}
