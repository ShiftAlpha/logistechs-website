
## Project Overview
Logistechs is a comprehensive, integrated platform that combines Transport Management, Resource Planning, Route Optimization, and Fleet Management software into a centralized solution for road freight operators across Africa.

## Technology Stack
- **Frontend Framework**: Flutter (Web)
- **State Management**: Flutter BLoC
- **Backend**: Firebase / Supabase (ready for integration)
- **Version Control**: Git
- **UI/UX**: Material Design 3 with custom theming
- **Animations**: animate_do, flutter_animate
- **Fonts**: Google Fonts (Poppins, Inter)

## Getting Started

### Prerequisites
- Flutter SDK (>= 3.7.0)
- Dart SDK (>= 3.7.0)
- Web browser (Chrome recommended for development)
- Git

### Installation

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the application**:
   ```bash
   flutter run -d chrome
   ```

3. **Build for production**:
   ```bash
   flutter build web
   ```

## Project Structure

```
logistechs-website/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── pages/                    # Page widgets (home, company, features, etc.)
│   ├── utils/                    # Constants, helpers, routes
│   └── widgets/                  # Reusable components (navbar, footer, forms)
├── assets/
│   ├── images/                   # Image assets
│   └── fonts/                    # Custom fonts
└── web/                          # Web-specific files
```

## Key Features

### Pages
1. **Home**: Welcome section, benefits grid, demo form
2. **Company**: Our Story, Vision and Mission
3. **Features**: Platform features with carousel
4. **FAQs**: Expandable question panels
5. **Contact**: Contact form and information
6. **Why Choose**: Value propositions and brochure download

### Components
- Responsive navigation bar with dropdown menus
- Animated social media icons
- Contact forms with validation
- Scroll-to-top footer
- Mobile-responsive layouts

## Configuration

Update contact details and social links in `lib/utils/constants.dart`.

## Coding Standards
- PEAK coding standards
- Comprehensive documentation
- Responsive design
- Type safety and error handling

## Contact

- Phone: +27 64 750 8514
- Email: ask@logistechs.com
- Location: 431 The William, Deinfern, Johannesburg

---

**Copyright © 2025 LOGISTECHS | Powered by Genesis**
