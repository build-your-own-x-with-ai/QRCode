//
//  ContentViewTests.swift
//  QrCode_iOSTests
//
//  Created by i on 2025/9/11.
//

import XCTest
import SwiftUI
@testable import QrCode_iOS

final class ContentViewTests: XCTestCase {
    
    func testContentViewInitialization() {
        // Test that ContentView can be initialized
        let contentView = ContentView()
        XCTAssertNotNil(contentView, "ContentView should be initialized successfully")
    }
    
    func testQRCodeViewWithNilImage() {
        // Test QRCodeView with nil image
        let qrCodeView = QRCodeView(uiImage: nil)
        XCTAssertNotNil(qrCodeView, "QRCodeView should be initialized with nil image")
    }
    
    func testQRCodeViewWithValidImage() {
        // Create a simple UIImage for testing
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.black.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let qrCodeView = QRCodeView(uiImage: image)
        XCTAssertNotNil(qrCodeView, "QRCodeView should be initialized with valid image")
    }
}