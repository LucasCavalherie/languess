//
//  ResultScene.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import UIKit
import SwiftUI

class ResultScene: UIViewController {

    var correctLabel = UILabel()
    var correctCount: Int = 0
    
    var wrongLabel = UILabel()
    var wrongCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCorrectQuestions()
        setupWrongQuestions()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupCorrectQuestions() {
        // Add subview
        view.addSubview(correctLabel)
        
        // Style
        correctLabel.text = "Acertos: \(correctCount)"
        correctLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        correctLabel.textAlignment = .center
        correctLabel.textColor = .black
        
        // Autolayout
        correctLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            correctLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            correctLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func setupWrongQuestions() {
        // Add subview
        view.addSubview(wrongLabel)
        
        // Style
        wrongLabel.text = "Erros: \(wrongCount)"
        wrongLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        wrongLabel.textAlignment = .center
        wrongLabel.textColor = .black
        
        // Autolayout
        wrongLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            wrongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wrongLabel.topAnchor.constraint(equalTo: correctLabel.bottomAnchor, constant: 50)
        ])
    }
}

struct ResultScene_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: ResultScene())
    }
}
