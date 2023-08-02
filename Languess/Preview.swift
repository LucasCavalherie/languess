//
//  Preview.swift
//  Languess
//
//  Created by Lucas Cavalherie on 01/08/23.
//

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    let scene : UIViewController
    func makeUIViewController(context: Context) -> some UIViewController {
        return scene
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
