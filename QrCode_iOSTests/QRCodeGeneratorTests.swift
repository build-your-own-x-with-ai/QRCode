//
//  QRCodeGeneratorTests.swift
//  QrCode_iOSTests
//
//  Created by i on 2025/9/11.
//

import XCTest
@testable import QrCode_iOS

final class QRCodeGeneratorTests: XCTestCase {
    
    func testGenerateQRCodeWithValidString() {
        let qrGenerator = QRCodeGenerator.shared
        let testString = "Hello, World!"
        
        let qrImage = qrGenerator.generateQRCode(from: testString)
        
        XCTAssertNotNil(qrImage, "QR code should be generated for valid string")
    }
    
    func testGenerateQRCodeWithEmptyString() {
        let qrGenerator = QRCodeGenerator.shared
        let testString = ""
        
        let qrImage = qrGenerator.generateQRCode(from: testString)
        
        XCTAssertNotNil(qrImage, "QR code should be generated even for empty string")
    }
    
    func testGenerateQRCodeWithUrl() {
        let qrGenerator = QRCodeGenerator.shared
        let testUrl = "https://www.apple.com"
        
        let qrImage = qrGenerator.generateQRCode(from: testUrl)
        
        XCTAssertNotNil(qrImage, "QR code should be generated for URL")
    }
    
    func testGenerateQRCodeWithSpecialCharacters() {
        let qrGenerator = QRCodeGenerator.shared
        let testString = "Hello, 世界! 🌍"
        
        let qrImage = qrGenerator.generateQRCode(from: testString)
        
        XCTAssertNotNil(qrImage, "QR code should be generated for string with special characters")
    }
    
    func testGenerateQRCodeWithLongString() {
        let qrGenerator = QRCodeGenerator.shared
        let testString = String(repeating: "A", count: 1000)
        
        let qrImage = qrGenerator.generateQRCode(from: testString)
        
        XCTAssertNotNil(qrImage, "QR code should be generated for long string")
    }
}