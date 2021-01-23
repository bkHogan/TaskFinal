//
//  AddImagePickerView.swift
//  FinalTaskApp
//
//  Created by Yusen Zhou on 1/23/21.
//

import Foundation
import SwiftUI

struct AddImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeCoordinator() -> AddImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AddImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        let parent: AddImagePickerView
        init(parent: AddImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage{
                let pngImageData = selectedImage.pngData()
                print(pngImageData ?? 0)
                self.parent.selectedImage = selectedImage
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: AddImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddImagePickerView>) {
        
    }
}
