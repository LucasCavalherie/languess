//
//  QuizData.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import Foundation

// Estrutura para representar o quizData
struct QuizData {
    let word: String
    let correctLanguage: String
    let options: [String]
}

// Função para fornecer os dados do quiz
func getQuizData() -> [QuizData] {
    // Substitua os dados abaixo pelas suas palavras e opções do quiz
    let quizData: [QuizData] = [
        QuizData(word: "Apple", correctLanguage: "Inglês", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "Table", correctLanguage: "Inglês", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "Casa", correctLanguage: "Espanhol", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "House", correctLanguage: "Inglês", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "Chien", correctLanguage: "Francês", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "Ocean", correctLanguage: "Inglês", options: ["Francês", "Espanhol", "Alemão", "Inglês"]),
        QuizData(word: "Montaña", correctLanguage: "Espanhol", options: ["Francês", "Alemão", "Espanhol", "Inglês"]),
        QuizData(word: "Jardim", correctLanguage: "Português", options: ["Espanhol", "Português", "Inglês", "Francês"]),
        QuizData(word: "Soleil", correctLanguage: "Francês", options: ["Espanhol", "Italiano", "Francês", "Inglês"]),
        QuizData(word: "Lago", correctLanguage: "Espanhol", options: ["Espanhol", "Alemão", "Inglês", "Francês"]),
        QuizData(word: "Gato", correctLanguage: "Espanhol", options: ["Espanhol", "Italiano", "Inglês", "Francês"]),
        QuizData(word: "Mesa", correctLanguage: "Espanhol", options: ["Espanhol", "Alemão", "Inglês", "Francês"]),
        QuizData(word: "Fenêtre", correctLanguage: "Francês", options: ["Italiano", "Francês", "Espanhol", "Inglês"]),
        QuizData(word: "Schule", correctLanguage: "Alemão", options: ["Inglês", "Alemão", "Francês", "Italiano"]),
        QuizData(word: "Pássaro", correctLanguage: "Português", options: ["Italiano", "Português", "Inglês", "Espanhol"]),
        QuizData(word: "Sonne", correctLanguage: "Alemão", options: ["Espanhol", "Alemão", "Italiano", "Inglês"]),
        QuizData(word: "Árvore", correctLanguage: "Português", options: ["Francês", "Espanhol", "Português", "Inglês"]),
        QuizData(word: "Luna", correctLanguage: "Espanhol", options: ["Espanhol", "Francês", "Italiano", "Inglês"]),
        QuizData(word: "Cielo", correctLanguage: "Espanhol", options: ["Alemão", "Francês", "Espanhol", "Português"]),
        QuizData(word: "Maison", correctLanguage: "Francês", options: ["Inglês", "Espanhol", "Francês", "Alemão"]),
        QuizData(word: "Vento", correctLanguage: "Italiano", options: ["Inglês", "Espanhol", "Italiano", "Francês"]),
        QuizData(word: "Sol", correctLanguage: "Português", options: ["Espanhol", "Português", "Italiano", "Francês"]),
        QuizData(word: "Haus", correctLanguage: "Alemão", options: ["Alemão", "Espanhol", "Francês", "Italiano"]),
        QuizData(word: "Tierra", correctLanguage: "Espanhol", options: ["Inglês", "Espanhol", "Italiano", "Português"]),
        QuizData(word: "Arbre", correctLanguage: "Francês", options: ["Alemão", "Espanhol", "Francês", "Italiano"]),
        QuizData(word: "Ventana", correctLanguage: "Espanhol", options: ["Italiano", "Espanhol", "Alemão", "Francês"]),
        QuizData(word: "Licht", correctLanguage: "Alemão", options: ["Alemão", "Italiano", "Francês", "Espanhol"]),
        QuizData(word: "Terra", correctLanguage: "Italiano", options: ["Espanhol", "Italiano", "Francês", "Alemão"]),
    ]
    return quizData
}
