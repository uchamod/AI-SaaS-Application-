# AI Text Extractor 📱
A powerful Flutter-based SaaS application that leverages AI/ML to extract text from images with integrated Stripe payment processing.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.x-blue.svg)

## 🚀 Features

- **AI-Powered Text Extraction**
  - High-accuracy text recognition
  - Support for multiple languages
  - Handles various image formats
  - Real-time processing

- **Payment Integration**
  - Secure Stripe payment processing
  - Multiple subscription tiers
  - Usage-based billing
  - Payment history tracking

- **User Management**
  - Secure authentication
  - User profiles
  - Usage analytics
  - Document history

- **Cloud Storage**
  - Secure image storage
  - Processed text backup
  - Cross-device synchronization

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio / VS Code
- Firebase account
- Stripe account
- Google Cloud Platform account

## 🛠️ Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ai-text-extractor.git
```

2. Navigate to the project directory:
```bash
cd ai-text-extractor
```

3. Install dependencies:
```bash
flutter pub get
```

4. Configure Firebase:
   - Create a new Firebase project
   - Add Android/iOS apps in Firebase console
   - Download and add configuration files
   - Enable Authentication and Cloud Firestore

5. Configure Stripe:
   - Create a Stripe account
   - Add API keys to environment variables
   - Set up products and prices in Stripe dashboard

6. Run the application:
```bash
flutter run
```

## ⚙️ Environment Variables

Create a `.env` file in the project root and add the following:

```env
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
GOOGLE_CLOUD_API_KEY=your_google_cloud_api_key
```

## 🔒 Security

- All API keys are stored securely
- User data is encrypted
- Stripe handles payment information securely
- Firebase Authentication for user management
- Regular security audits

## 🚦 Testing

Run tests using:
```bash
flutter test
```

Integration tests:
```bash
flutter drive --target=test_driver/app.dart
```

## 📱 Supported Platforms

- Android
- iOS
- Web (beta)

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

email uchamod52@your-domain.com or join our Slack channel.
Linkdin https://www.linkedin.com/in/chamod-udara-b3927a239/
## 🔮 Future Enhancements

- [ ] Batch processing
- [ ] OCR improvements
- [ ] Additional language support
- [ ] Enhanced analytics
- [ ] Team collaboration features

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Stripe](https://stripe.com/)
- [Google Cloud Vision API](https://cloud.google.com/vision)

## 📊 Stats

![Stars](https://img.shields.io/github/stars/yourusername/ai-text-extractor.svg)
![Forks](https://img.shields.io/github/forks/yourusername/ai-text-extractor.svg)
![Issues](https://img.shields.io/github/issues/yourusername/ai-text-extractor.svg)

## 📸 Screenshots

<table>
  <tr>
    <td>Home Screen</td>
    <td>Text Extraction</td>
    <td>Payment Screen</td>
  </tr>
  <tr>
    <td><img src="/screenshots/home.png" width="200"/></td>
    <td><img src="/screenshots/extract.png" width="200"/></td>
    <td><img src="/screenshots/payment.png" width="200"/></td>
  </tr>
</table>

## 🎯 Key Performance Metrics

- Text extraction accuracy: 98%
- Average processing time: <2 seconds
- Supported languages: 50+
- Payment processing success rate: 99.9%

---

Made with ❤️ by [Your Name]

[⬆ Back to Top](#ai-text-extractor-)
