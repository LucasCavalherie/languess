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
    var totalTitle = UILabel()
    
    var correctTitle = UILabel()
    var correctLabel = UILabel()
    var correctCount: Int = 0
    
    var wrongTitle = UILabel()
    var wrongLabel = UILabel()
    var wrongCount: Int = 0
    
    var resultData: [ResultData] = [
        ResultData(word: "Palavra", correct: true),
        ResultData(word: "Palavra1", correct: false),
        ResultData(word: "Palavra2", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
        ResultData(word: "Palavra3", correct: true),
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var view = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifer)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let record = (UserDefaults.standard.value(forKey: "highScore") != nil) ? UserDefaults.standard.value(forKey: "highScore") as! Int : 0
        if correctCount > record {
            UserDefaults.standard.set(correctCount, forKey: "highScore")
            RecordController.updateRecord(newRecord: correctCount)
        }
        
        // Add subview
        //view.addSubview(totalTitle)
        //view.addSubview(totalLabel)
        
        view.addSubview(correctTitle)
        view.addSubview(correctLabel)
        
        view.addSubview(wrongTitle)
        view.addSubview(wrongLabel)
        
        
        setupButton()
        //setupTotalQuestions()
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
        
        firstButton.setTitle("Jogar Novamente", for: .normal)
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
            firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            firstButton.widthAnchor.constraint(equalToConstant: 300),
            firstButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupTotalQuestions() {
        // Style
        totalTitle.text = "Total"
        totalTitle.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        totalTitle.textAlignment = .center
        totalTitle.textColor = .label
        
        totalLabel.text = "\(correctCount + wrongCount)"
        totalLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        totalLabel.textAlignment = .center
        totalLabel.textColor = .label
        
        // Autolayout
        totalTitle.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            totalTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalTitle.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 50),
            totalLabel.centerXAnchor.constraint(equalTo: totalTitle.centerXAnchor),
            totalLabel.topAnchor.constraint(equalTo: totalTitle.bottomAnchor, constant: 10)
        ])
    }
    
    func setupCorrectQuestions() {
        // Style
        correctTitle.text = "Acertos"
        correctTitle.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        correctTitle.textAlignment = .center
        correctTitle.textColor = .label
        
        correctLabel.text = "\(correctCount)"
        correctLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        correctLabel.textAlignment = .center
        correctLabel.textColor = .label
        
        // Autolayout
        correctTitle.translatesAutoresizingMaskIntoConstraints = false
        correctLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            correctTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            correctTitle.trailingAnchor.constraint(equalTo: wrongLabel.leadingAnchor),
            correctTitle.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 50),
            correctLabel.centerXAnchor.constraint(equalTo: correctTitle.centerXAnchor),
            correctLabel.topAnchor.constraint(equalTo: correctTitle.bottomAnchor, constant: 10)
        ])
    }
    
    func setupWrongQuestions() {
        // Style
        wrongTitle.text = "Erros"
        wrongTitle.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        wrongTitle.textAlignment = .center
        wrongTitle.textColor = .label
        
        wrongLabel.text = "\(wrongCount)"
        wrongLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        wrongLabel.textAlignment = .center
        wrongLabel.textColor = .label
        
        // Autolayout
        wrongTitle.translatesAutoresizingMaskIntoConstraints = false
        wrongLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains
        NSLayoutConstraint.activate([
            wrongTitle.leadingAnchor.constraint(equalTo: correctLabel.trailingAnchor),
            wrongTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrongTitle.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 50),
            wrongLabel.centerXAnchor.constraint(equalTo: wrongTitle.centerXAnchor),
            wrongLabel.topAnchor.constraint(equalTo: wrongTitle.bottomAnchor, constant: 10)
        ])
    }
    
    func setupAnswers() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: wrongLabel.bottomAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func goToFirstScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension ResultScene: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifer, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        cell.setUpView(text: resultData[indexPath.row].word, correct: resultData[indexPath.row].correct)
        return cell
    }
}

extension ResultScene: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Apertou a opção na célula \(indexPath.row + 1)")
    }
}

extension ResultScene: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

struct ResultScene_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable(scene: ResultScene())
    }
}
