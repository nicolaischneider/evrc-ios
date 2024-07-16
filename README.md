# Electronic Vehicle Registration Certificate App

## Description

This iOS application, developed as part of my master thesis, exemplifies the complete user journey for managing electronic Vehicle Registration Certificates (eVRCs). It demonstrates a range of functionalities essential for the digital management and verification of eVRCs:

- **Issuance of New Documents**: Users can issue new eVRCs directly through the app.
- **Management of Existing Certificates**: Features include listing all certificates, viewing detailed information, and deleting certificates as needed.
- **Document Sharing with Revocable Access**: Allows users to share their eVRCs while retaining the ability to revoke access at any time.
- **Routine Police Checks**: Supports scenarios such as traffic stops where police need to verify an eVRC.
- **Receiving eVRCs**: Enables users to accept eVRCs transferred from other users.

The application was developed natively using SwiftUI and utilizes Apple's SF Symbols to enhance the user interface, operating primarily as an advanced prototype. This setup is designed to simulate real user interactions and application functionalities, allowing for a comprehensive demonstration and evaluation of the user experience and workflow. Additionally, a mock [reader application](https://github.com/nicolaischneider/evrc-verifier-ios) was also developed to showcase the verification process during police control scenarios.

## Setup

### Prerequisites
- **macOS**: The development environment for iOS apps.
- **Xcode**: Apple’s integrated development environment (IDE) for macOS, used for building iOS applications.
- **iOS Device**: An iPhone to run the application.

### Installation
1. **Clone the Repository**

2. **Open the Project**
- Launch Xcode and select 'Open an existing project'.
- Navigate to the cloned repository folder and open the `.xcodeproj` file.

3. **Set up the iOS Device or Simulator**
- Connect your iOS device to your Mac and select it in Xcode, or use an iOS simulator.

4. **Run the Application**
- Press the 'Run' button in Xcode to build and run the app on your chosen device.

### Test Documents

Use the following test documents to issue a new eVRC into your app:

License Plate Number **B DR 123**
<img src="qrCode/bdr123" width="250" height="250" alt="B DR 123">

License Plate Number **AB CD 123**
<img src="qrCode/abcd123" width="250" height="250" alt="AB CD 123">
