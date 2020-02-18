//
//  ContentView.swift
//  InvertSelfieImage
//
//  Created by ramil on 18.02.2020.
//  Copyright © 2020 com.ri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var imageSelected: Image? = nil
    @State var showGetImageView = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showGetImageView.toggle()
                }) {
                    Text("Take Selfie")
                }
                
                Spacer().frame(height: 50)
                
                imageSelected?
                    .resizable()
                    .frame(width: 300, height: 300)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            
            if (showGetImageView) {
                GetImageView(showBool: $showGetImageView, getImage: $imageSelected)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var showCoordinatorBool: Bool
    @Binding var coordinatorImage: Image?
    
    init(showBool: Binding<Bool>, coordinatedImage: Binding<Image?>) {
        _showCoordinatorBool = showBool
        _coordinatorImage = coordinatedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let gotImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        coordinatorImage = Image(uiImage: gotImage)
        showCoordinatorBool = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showCoordinatorBool = false
    }
}

struct GetImageView {
    
    @Binding var showBool: Bool
    @Binding var getImage: Image?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(showBool: $showBool, coordinatedImage: $getImage)
    }
}

extension GetImageView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GetImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // TODO: Uncomment Me!
        //picker.sourceType = .camera
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<GetImageView>) {
            
    }
}
