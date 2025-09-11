//
//  ContentView.swift
//  QrCode_iOS
//
//  Created by i on 2025/9/11.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var qrImage: UIImage? = nil
    @State private var isGenerating: Bool = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showImagePicker = false
    @State private var overlayImage: UIImage? = nil
    @State private var overlaySizeRatio: CGFloat = 0.2
    @State private var resolution: CGFloat = 10.0
    @State private var isFullScreen = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("QR Code Generator")
                        .font(.largeTitle)
                        .bold()
                    
                    // Input Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Enter text or URL")
                            .font(.headline)
                        
                        HStack {
                            TextField("Enter text or URL", text: $inputText, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(isGenerating)
                                .lineLimit(1...5) // Allow multiline input
                            
                            Button(action: {
                                inputText = ""
                                qrImage = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                            .disabled(inputText.isEmpty)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Overlay Image Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Overlay Image")
                            .font(.headline)
                        
                        HStack {
                            Button(action: {
                                showImagePicker = true
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                    Text("Select Image")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            
                            if overlayImage != nil {
                                Button(action: {
                                    overlayImage = nil
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Remove")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        
                        if let image = overlayImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .cornerRadius(10)
                        }
                        
                        // Overlay size slider
                        VStack(alignment: .leading) {
                            Text("Overlay Size: \(Int(overlaySizeRatio * 100))%")
                                .font(.subheadline)
                            Slider(value: $overlaySizeRatio, in: 0.05...0.5, step: 0.05)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Resolution Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Resolution")
                            .font(.headline)
                        
                        VStack(alignment: .leading) {
                            Text("Scale Factor: \(Int(resolution))x")
                                .font(.subheadline)
                            Slider(value: $resolution, in: 1...30, step: 1)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Generate Button
                    Button(action: generateQRCode) {
                        if isGenerating {
                            ProgressView()
                                .scaleEffect(1.5)
                        } else {
                            Text("Generate QR Code")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(inputText.isEmpty || isGenerating)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    // Display Section
                    // Use a fixed frame that accommodates the maximum scale to prevent layout issues
                    QRCodeView(uiImage: qrImage)
                        .scaleEffect(resolution / 10.0)
                        // Set a fixed frame that can contain the scaled image without affecting layout
                        .frame(width: 200 * (resolution / 10.0), height: 200 * (resolution / 10.0))
                        // Center the scaled content
                        .clipped()
                        .overlay(
                            // Show actual size when scaled for visual reference
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        // Add tap gesture for full screen
                        .onTapGesture {
                            if qrImage != nil {
                                isFullScreen = true
                            }
                        }
                    
                    // Action Section
                    HStack {
                        Button(action: saveQRCode) {
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                        .disabled(qrImage == nil)
                        .buttonStyle(.bordered)
                        
                        Button(action: shareQRCode) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .disabled(qrImage == nil)
                        .buttonStyle(.bordered)
                    }
                    .padding()
                }
                .padding()
                // Add bottom padding to ensure scaled QR code doesn't overlap with bottom elements
                .padding(.bottom, max(0, (resolution / 10.0 - 1.0) * 200))
            }
            .alert("QR Code Generator", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $overlayImage)
            }
            // Dismiss keyboard when tapping outside
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            // Full screen overlay
            if isFullScreen, let image = qrImage {
                Color.black.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isFullScreen = false
                    }
                
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            isFullScreen = false
                        }
                    
                    Button("Close") {
                        isFullScreen = false
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
    }
    
    private func generateQRCode() {
        isGenerating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let overlay = overlayImage {
                // Pass the resolution as the scale factor for QR code generation
                qrImage = QRCodeGenerator.shared.generateQRCode(from: inputText, withOverlayImage: overlay, overlaySizeRatio: overlaySizeRatio, scale: resolution)
            } else {
                // Pass the resolution as the scale factor for QR code generation
                qrImage = QRCodeGenerator.shared.generateQRCode(from: inputText, scale: resolution)
            }
            isGenerating = false
            
            if qrImage == nil {
                alertMessage = "Failed to generate QR code"
                showingAlert = true
            }
        }
    }
    
    private func saveQRCode() {
        guard let image = qrImage else { return }
        
        // Convert to PNG data to ensure PNG format
        guard let pngData = image.pngData() else {
            alertMessage = "Failed to convert QR code to PNG"
            showingAlert = true
            return
        }
        
        // Create a new UIImage from PNG data
        guard let pngImage = UIImage(data: pngData) else {
            alertMessage = "Failed to create PNG image"
            showingAlert = true
            return
        }
        
        // Save to Photos using a different approach that doesn't require @objc
        UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
        
        // Show success message immediately (since we can't get the callback)
        alertMessage = "QR code saved to Photos as PNG"
        showingAlert = true
    }
    
    private func shareQRCode() {
        guard let image = qrImage else { return }
        
        // Share the QR code
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // Get the SwiftUI window and present the activity view controller
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        window.rootViewController?.present(activityVC, animated: true)
    }
}

// Image picker view for selecting overlay images
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ContentView()
}