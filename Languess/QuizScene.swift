//
//  QuizScene.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import SwiftUI
import UIKit
import CoreHaptics

class QuizScene: UIViewController {
    
    var timer: Timer?
    var countdown: Int = 30
    var countdownLabel: UILabel!
    var currentQuestionIndex: Int = 0
    var quizData: [QuizData] = []
    var wordLabel = UILabel()
    var optionButtons: [UIButton] = []
    
    var correctQuestions: Int = 0
    var wrongQuestions: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizData = getQuizData()
            
        // Embaralhar as perguntas
        quizData = quizData.shuffled()
        
        setupCountdown()
        startCountdown()
        setupTitle()
        setupButtons()
        
        goToNextQuestion()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupCountdown() {
        // Countdown Label
        countdownLabel = UILabel()
        countdownLabel.text = "30" // Valor inicial do contador
        countdownLabel.font = UIFont.systemFont(ofSize: 28, weight: .thin)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = .black
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countdownLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    func setupTitle() {
        // Add subview
        view.addSubview(wordLabel)
        
        // Style
        wordLabel.font = UIFont.systemFont(ofSize: 64.0, weight: .thin)
        wordLabel.textAlignment = .center
        wordLabel.textColor = .black
        
        // Autolayout
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 100),
        ])
    }
    
    func setupButtons() {
        for _ in 0..<4 {
            let button = UIButton(type: .system)
            
            button.configuration?.baseBackgroundColor = .systemBackground
            button.configuration?.baseForegroundColor = .black
            button.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10.0
            
            button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            optionButtons.append(button)
        }
        
        // Constraints
        NSLayoutConstraint.activate([
            optionButtons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionButtons[0].topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 150),
            optionButtons[0].widthAnchor.constraint(equalToConstant: 300),
            optionButtons[0].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionButtons[1].topAnchor.constraint(equalTo: optionButtons[0].bottomAnchor, constant: 30),
            optionButtons[1].widthAnchor.constraint(equalToConstant: 300),
            optionButtons[1].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionButtons[2].topAnchor.constraint(equalTo: optionButtons[1].bottomAnchor, constant: 30),
            optionButtons[2].widthAnchor.constraint(equalToConstant: 300),
            optionButtons[2].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[3].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionButtons[3].topAnchor.constraint(equalTo: optionButtons[2].bottomAnchor, constant: 30),
            optionButtons[3].widthAnchor.constraint(equalToConstant: 300),
            optionButtons[3].heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc func goToNextScreen() {
        let nextScreen = ResultScene()
        nextScreen.correctCount = correctQuestions
        nextScreen.wrongCount = wrongQuestions
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        countdown -= 1
        countdownLabel.text = "\(countdown)"
        
        if countdown <= 10 {
            countdownLabel.textColor = .red
            countdownLabel.font = UIFont.systemFont(ofSize: 28, weight: .regular)
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
        
        
        if countdown <= 0 {
            timer?.invalidate()
            goToNextScreen()
        }
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        let currentQuestion = quizData[currentQuestionIndex]
        let selectedOption = sender.title(for: .normal) ?? ""
        
        if selectedOption == currentQuestion.correctLanguage {
            correctQuestions = correctQuestions + 1
            sender.backgroundColor = .green
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } else {
            wrongQuestions = wrongQuestions + 1
            sender.backgroundColor = .red
            
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
        
        currentQuestionIndex = currentQuestionIndex + 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.backgroundColor = .clear
            self.goToNextQuestion()
        }
    }
    
    func goToNextQuestion() {
        if currentQuestionIndex < quizData.count{
            let currentQuestion = quizData[currentQuestionIndex]
            wordLabel.text = currentQuestion.word
            
            for i in 0..<4 {
                optionButtons[i].setTitle(currentQuestion.options[i], for: .normal)
            }
        } else {
            goToNextScreen()
        }
    }


}

struct QuizScene_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: QuizScene())
    }
}
