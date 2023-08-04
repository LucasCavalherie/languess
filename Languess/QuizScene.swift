//
//  QuizScene.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import SwiftUI
import UIKit
import AVFoundation

class QuizScene: UIViewController {
    
    var timer: Timer?
    var countdown: Int = 30
    var countdownLabel: UILabel!
    var currentQuestionIndex: Int = 0
    var quizData: [QuizData] = []
    var resultData: [ResultData] = []
    var wordLabel = UILabel()
    var optionButtons: [UIButton] = []
    
    var correctQuestions: Int = 0
    var wrongQuestions: Int = 0
    
    var audioPlayer: AVAudioPlayer?

    func setupAudioPlayer() {
        guard let audioURL = Bundle.main.url(forResource: "trilhaSonora", withExtension: "mp3") else {
            print("Arquivo de áudio não encontrado.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Erro ao criar o player de áudio: \(error.localizedDescription)")
        }
    }
    
    
    
    // Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudioPlayer()
        
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
        countdownLabel.text = "\(countdown)"
        countdownLabel.font = UIFont.systemFont(ofSize: 28, weight: .thin)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = UIColor.label
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
        wordLabel.textColor = .label
        
        // Autolayout
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 100),
        ])
    }
    
    func setupButtons() {
        // add collection view diffable
        for _ in 0..<4 {
            let button = UIButton(type: .system)
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
            button.setTitleColor(.label, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.systemGray.cgColor
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
        nextScreen.resultData = resultData
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
            audioPlayer?.pause()
            goToNextScreen()
        }
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        let currentQuestion = quizData[currentQuestionIndex]
        let selectedOption = sender.title(for: .normal) ?? ""
        let correct = selectedOption == currentQuestion.correctLanguage
        
        if correct {
            correctQuestions = correctQuestions + 1
            sender.backgroundColor = .systemGreen
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } else {
            wrongQuestions = wrongQuestions + 1
            sender.backgroundColor = .systemRed
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
        
        resultData.append(
            ResultData(word: quizData[currentQuestionIndex].word, correct: correct)
        )
        
        currentQuestionIndex = currentQuestionIndex + 1
        
        for i in 0..<4 {
            optionButtons[i].isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.backgroundColor = .clear
            sender.setTitleColor(.label, for: .normal)
            sender.layer.borderColor = UIColor.systemGray.cgColor
            
            for i in 0..<4 {
                self.optionButtons[i].isEnabled = true
            }
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
