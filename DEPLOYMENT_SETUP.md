# GitHub Actions Firebase Deployment Setup Guide

This guide explains how to set up automated deployment to Firebase Hosting using GitHub Actions.

## Overview

The workflow automatically deploys your Flutter web app to Firebase Hosting whenever you push to the `main` or `master` branch.

## Prerequisites

1. A Firebase project (already set up: `logistechs-website`)
2. A GitHub repository for your code
3. Firebase CLI installed locally (for generating service account)

## Setup Steps

### Step 1: Generate Firebase Service Account Key

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **logistechs-website**
3. Click the gear icon (⚙️) next to "Project Overview" → **Project Settings**
4. Navigate to the **Service Accounts** tab
5. Click **Generate New Private Key**
6. Confirm by clicking **Generate Key**
7. A JSON file will be downloaded - **keep this file secure!**

### Step 2: Add Secret to GitHub Repository

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Create a secret with:
   - **Name:** `FIREBASE_SERVICE_ACCOUNT`
   - **Value:** Paste the **entire contents** of the JSON file you downloaded in Step 1
5. Click **Add secret**

### Step 3: Verify Workflow File

The workflow file `.github/workflows/firebase-deploy.yml` has been created with:

- **Triggers:** Automatic deployment on push to main/master, or manual trigger
- **Flutter Version:** 3.24.5 stable
- **Web Renderer:** CanvasKit (for better performance)
- **Firebase Project:** logistechs-website

### Step 4: Test the Deployment

#### Option 1: Push to Repository
```bash
cd /home/logistechs/logistechs_website/logistechs-website

# Add and commit your changes
git add .
git commit -m "Add GitHub Actions workflow for Firebase deployment"

# Push to trigger deployment
git push origin master
```

#### Option 2: Manual Trigger
1. Go to your GitHub repository
2. Click **Actions** tab
3. Select **Deploy to Firebase Hosting** workflow
4. Click **Run workflow** button
5. Select branch and click **Run workflow**

### Step 5: Monitor Deployment

1. Go to **Actions** tab in your GitHub repository
2. Click on the running workflow
3. Watch the build and deployment progress
4. Once complete (✓), your site will be live!

## Workflow Details

### What the Workflow Does

1. **Checkout code** - Gets latest code from repository
2. **Set up Flutter** - Installs Flutter 3.24.5 stable
3. **Install dependencies** - Runs `flutter pub get`
4. **Build web** - Compiles Flutter app to optimized web build
5. **Deploy to Firebase** - Uploads build to Firebase Hosting

### Build Output

- Build artifacts: `build/web/`
- Deployment channel: `live` (production)
- Hosting URL: https://logistechs-website.web.app (or your custom domain)

## Troubleshooting

### Error: "FIREBASE_SERVICE_ACCOUNT secret not found"
- Make sure you added the secret in GitHub Settings → Secrets → Actions
- Secret name must be exactly: `FIREBASE_SERVICE_ACCOUNT`
- Value must be the complete JSON file contents

### Error: "Firebase project not found"
- Verify `projectId: logistechs-website` matches your Firebase project
- Check that the service account has proper permissions

### Build Fails
- Check Flutter version compatibility
- Run `flutter build web --release` locally to test
- Review error logs in GitHub Actions

### Deployment Succeeds but Site Not Updated
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Check Firebase Hosting dashboard for deployment status
- Verify correct project ID in workflow file

## Manual Deployment (Alternative)

If you prefer manual deployment:

```bash
# Build the web app
flutter build web --release --web-renderer canvaskit

# Deploy to Firebase
firebase deploy --only hosting
```

## Useful Commands

```bash
# View deployment history
firebase hosting:channel:list

# Test locally before deployment
flutter build web --release
firebase serve --only hosting

# View live site
firebase open hosting:site
```

## Security Notes

⚠️ **Important Security Practices:**

1. **Never commit** the Firebase service account JSON file to your repository
2. **Keep secrets secure** - only store in GitHub Secrets
3. **Rotate keys regularly** - generate new service account keys periodically
4. **Limit permissions** - service account should only have necessary permissions
5. **Review workflow logs** - but note they won't expose secret values

## Next Steps

After successful deployment:

1. ✅ Set up custom domain (optional)
2. ✅ Configure caching rules in `firebase.json`
3. ✅ Add SSL certificate (auto-configured by Firebase)
4. ✅ Monitor analytics in Firebase Console
5. ✅ Set up preview channels for testing

## Support

- Firebase Documentation: https://firebase.google.com/docs/hosting
- GitHub Actions: https://docs.github.com/en/actions
- Flutter Web: https://docs.flutter.dev/platform-integration/web

---

**Status:** Ready for deployment! Just add the `FIREBASE_SERVICE_ACCOUNT` secret and push your code.
