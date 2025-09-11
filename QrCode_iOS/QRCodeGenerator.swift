//
//  QRCodeGenerator.swift
//  QrCode_iOS
//
//  Created by i on 2025/9/11.
//

import Foundation
import CoreImage
import UIKit

class QRCodeGenerator {
    static let shared = QRCodeGenerator()
    
    private init() {}
    
    func generateQRCode(from string: String, correctionLevel: String = "M", scale: CGFloat = 10.0) -> UIImage? {
        guard let data = string.data(using: .utf8) else { return nil }
        
        let context = CIContext()
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue(correctionLevel, forKey: "inputCorrectionLevel")
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        // Scale the image up for better clarity based on the resolution parameter
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }
        
        // Create UIImage with PNG format
        return UIImage(cgImage: cgImage)
    }
    
    func generateQRCode(from string: String, withOverlayImage overlayImage: UIImage?, overlaySizeRatio: CGFloat = 0.2, scale: CGFloat = 10.0) -> UIImage? {
        // Generate the base QR code
        guard let baseQRCode = generateQRCode(from: string, scale: scale) else { return nil }
        
        // If no overlay image, return the base QR code
        guard let overlay = overlayImage else { return baseQRCode }
        
        // Create a new image context
        let baseSize = baseQRCode.size
        let renderer = UIGraphicsImageRenderer(size: baseSize)
        
        // Draw the base QR code and overlay
        let combinedImage = renderer.image { ctx in
            // Draw the base QR code
            baseQRCode.draw(in: CGRect(origin: .zero, size: baseSize))
            
            // Calculate overlay size (as a ratio of the QR code size)
            let overlaySize = min(baseSize.width, baseSize.height) * overlaySizeRatio
            let overlayOrigin = CGPoint(
                x: (baseSize.width - overlaySize) / 2,
                y: (baseSize.height - overlaySize) / 2
            )
            
            // Draw the overlay image in the center
            overlay.draw(in: CGRect(origin: overlayOrigin, size: CGSize(width: overlaySize, height: overlaySize)))
        }
        
        return combinedImage
    }
}