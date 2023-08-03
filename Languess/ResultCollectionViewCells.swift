//
//  ResultCollectionViewCells.swift
//  Languess
//
//  Created by Lucas Cavalherie on 03/08/23.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    static let identifer: String = "ResultCollectionViewCell"
    
    private lazy var question: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 36.0, weight: .thin)
        view.textColor = .label
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(question)
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(question)
    }
    
    private func setUpConstraints() {
        question.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15).isActive = true
        question.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        question.heightAnchor.constraint(equalToConstant: 60).isActive = true
        question.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setUpView(text: String, correct: Bool) {
        question.text = text
        
        if correct {
            question.textColor = .white
            question.layer.backgroundColor = UIColor.systemGreen.cgColor
            question.layer.borderWidth = 1.0
            question.layer.borderColor = UIColor.systemGreen.cgColor
            question.layer.cornerRadius = 10
        } else {
            question.textColor = .white
            question.layer.backgroundColor = UIColor.systemRed.cgColor
            question.layer.borderWidth = 1.0
            question.layer.borderColor = UIColor.systemRed.cgColor
            question.layer.cornerRadius = 10
        }
    }
}
