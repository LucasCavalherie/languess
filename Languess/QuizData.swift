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
        QuizData(word: "Apple", correctLanguage: "English", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "Table", correctLanguage: "English", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "Casa", correctLanguage: "Spanish", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "House", correctLanguage: "English", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "Chien", correctLanguage: "French", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "Ocean", correctLanguage: "English", options: ["French", "Spanish", "German", "English"]),
        QuizData(word: "Montaña", correctLanguage: "Spanish", options: ["French", "German", "Spanish", "English"]),
        QuizData(word: "Jardim", correctLanguage: "Portuguese", options: ["Spanish", "Portuguese", "English", "French"]),
        QuizData(word: "Soleil", correctLanguage: "French", options: ["Spanish", "Italian", "French", "English"]),
        QuizData(word: "Lago", correctLanguage: "Spanish", options: ["Spanish", "German", "English", "French"]),
        QuizData(word: "Gato", correctLanguage: "Spanish", options: ["Spanish", "Italian", "English", "French"]),
        QuizData(word: "Mesa", correctLanguage: "Spanish", options: ["Spanish", "German", "English", "French"]),
        QuizData(word: "Fenêtre", correctLanguage: "French", options: ["Italian", "French", "Spanish", "English"]),
        QuizData(word: "Schule", correctLanguage: "German", options: ["English", "German", "French", "Italian"]),
        QuizData(word: "Pássaro", correctLanguage: "Portuguese", options: ["Italian", "Portuguese", "English", "Spanish"]),
        QuizData(word: "Sonne", correctLanguage: "German", options: ["Spanish", "German", "Italian", "English"]),
        QuizData(word: "Árvore", correctLanguage: "Portuguese", options: ["French", "Spanish", "Portuguese", "English"]),
        QuizData(word: "Luna", correctLanguage: "Spanish", options: ["Spanish", "French", "Italian", "English"]),
        QuizData(word: "Cielo", correctLanguage: "Spanish", options: ["German", "Italian", "Spanish", "Portuguese"]),
        QuizData(word: "Maison", correctLanguage: "French", options: ["English", "Spanish", "French", "German"]),
        QuizData(word: "Vento", correctLanguage: "Italian", options: ["English", "Spanish", "Italian", "French"]),
        QuizData(word: "Sol", correctLanguage: "Portuguese", options: ["Spanish", "Portuguese", "Italian", "French"]),
        QuizData(word: "Haus", correctLanguage: "German", options: ["German", "Spanish", "French", "Italian"]),
        QuizData(word: "Tierra", correctLanguage: "Spanish", options: ["English", "Spanish", "Italian", "Portuguese"]),
        QuizData(word: "Arbre", correctLanguage: "French", options: ["German", "Spanish", "French", "Italian"]),
        QuizData(word: "Ventana", correctLanguage: "Spanish", options: ["Italian", "Spanish", "German", "French"]),
        QuizData(word: "Licht", correctLanguage: "German", options: ["German", "Italian", "French", "Spanish"]),
        QuizData(word: "Terra", correctLanguage: "Italian", options: ["Spanish", "Italian", "French", "Portuguese"]),
    ]
    return quizData
}
