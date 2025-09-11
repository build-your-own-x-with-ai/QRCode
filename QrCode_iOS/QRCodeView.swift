//
//  QRCodeView.swift
//  QrCode_iOS
//
//  Created by i on 2025/9/11.
//

import SwiftUI

struct QRCodeView: View {
    var uiImage: UIImage?
    
    var body: some View {
        if let image = uiImage {
            Image(uiImage: image)
                .interpolation(.none) // Prevents blurriness
                .resizable()
                .scaledToFit()
                .frame(minWidth: 200, minHeight: 200)
                .background(Color.white)
        } else {
            // Placeholder when no QR code is generated
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(minWidth: 200, minHeight: 200)
                .overlay(
                    VStack {
                        Image(systemName: "qrcode")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No QR Code Generated")
                            .foregroundColor(.gray)
                    }
                )
        }
    }
}

#Preview {
    QRCodeView()
}