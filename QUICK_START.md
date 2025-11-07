# Quick Start: Firebase Deployment

## 🚀 One-Time Setup (Required)

### Get Firebase Service Account Key:
1. Visit: https://console.firebase.google.com/project/logistechs-website/settings/serviceaccounts/adminsdk
2. Click **"Generate New Private Key"**
3. Download the JSON file

### Add Secret to GitHub:
1. Go to GitHub repo → **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Name: `FIREBASE_SERVICE_ACCOUNT`
4. Value: Paste entire JSON file contents
5. Click **"Add secret"**

## 📦 Deploy Your Changes

### Automatic Deployment:
```bash
git add .
git commit -m "Your commit message"
git push origin master
```

That's it! GitHub Actions will automatically:
- ✅ Build your Flutter web app
- ✅ Deploy to Firebase Hosting
- ✅ Make it live at your domain

### Manual Deployment:
```bash
flutter build web --release --web-renderer canvaskit
firebase deploy --only hosting
```

## 📊 Check Deployment Status

1. **GitHub Actions**: https://github.com/YOUR_USERNAME/YOUR_REPO/actions
2. **Firebase Console**: https://console.firebase.google.com/project/logistechs-website/hosting

## 🌐 Your Live Site

- Firebase URL: https://logistechs-website.web.app
- Custom Domain: (if configured in Firebase Console)

## ⚡ Workflow Triggers

- ✅ Push to `main` or `master` branch
- ✅ Manual trigger from GitHub Actions tab

## 🔧 Local Testing

```bash
# Build and test locally
flutter build web --release
cd build/web
python3 -m http.server 8000

# Visit: http://localhost:8000
```

## 📝 Files Created

- `.github/workflows/firebase-deploy.yml` - GitHub Actions workflow
- `DEPLOYMENT_SETUP.md` - Detailed setup guide
- `QUICK_START.md` - This file

---

**Need help?** Check `DEPLOYMENT_SETUP.md` for detailed instructions.
