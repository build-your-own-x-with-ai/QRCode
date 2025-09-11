# QR Code Generator for iOS

A SwiftUI-based iOS application for generating customizable QR codes with advanced features.

## Features

- Generate QR codes from text or URLs
- Add image overlays to QR codes
- Adjust overlay size and position
- Control QR code resolution (1x to 30x)
- Full-screen preview mode
- Save QR codes as PNG format
- Share QR codes with other apps

## Screenshots

![QR Code App](screenshots/QRCode.png)

![iosdevlog](screenshots/iosdevlog.png)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/buld-your-own-x-with-ai/QRCode
   ```

2. Open `QrCode_iOS.xcodeproj` in Xcode

3. Build and run the project

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Usage

1. Enter text or a URL in the input field
2. (Optional) Add an overlay image by tapping "Select Image"
3. Adjust the overlay size using the slider
4. Set the desired resolution using the Resolution slider
5. Tap "Generate QR Code" to create your QR code
6. Tap the QR code to view it in full-screen mode
7. Use "Save" to save the QR code to your Photos library (saved as PNG)
8. Use "Share" to share the QR code with other apps

## Customization

### Overlay Images
- Tap "Select Image" to choose an image from your photo library
- Adjust the overlay size with the slider (5% to 50% of QR code size)
- Tap "Remove" to clear the selected overlay image

### Resolution Control
- Use the Resolution slider to control the quality of the generated QR code
- Values range from 1x (lower quality) to 30x (higher quality)
- Higher resolution values create larger, more detailed QR codes

## Technical Details

### Architecture
The app follows a modular structure with separate components:
- `QRCodeGenerator.swift`: Handles QR code generation using CoreImage
- `ContentView.swift`: Main SwiftUI view with all UI elements
- `QRCodeView.swift`: Dedicated view for displaying QR codes

### QR Code Generation
- Uses CoreImage's `CIQRCodeGenerator` filter
- Supports customizable error correction levels
- Generates lossless PNG images

### Image Overlay
- Combines base QR code with overlay images using UIGraphicsImageRenderer
- Maintains aspect ratio of overlay images
- Positions overlays at the center of the QR code

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Remote Repository

The project is hosted at: https://github.com/buld-your-own-x-with-ai/QRCode