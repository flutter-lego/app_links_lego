[![lego project](https://img.shields.io/badge/powered%20by-lego-blue?logo=github)](https://github.com/melodysdreamj/lego)
[![pub package](https://img.shields.io/pub/v/app_links_lego.svg)](https://pub.dartlang.org/packages/app_links_lego)

# app_links_lego
lego that apply app_links.

##  Installation
1. open terminal in the lego project root directory, enter the following command for install cli.
   and create a new lego project if you don't have one.
```bash
flutter pub global activate lego_cli
lego create
```
2. in terminal, enter the following command for add lego to project.
```bash
lego add app_links_lego
```

3. apply all step in [app_links_guide](https://github.com/melodysdreamj/app_links/tree/master)


## Configuration

### App Configuration
1. If the juneflow project doesn't exist, please create it by following [this guide](https://doc.juneflow.org/).
2. open terminal in the juneflow project root directory, enter the following command.
 ```bash
 june add app_links_module
 ```

### WebSite Configuration
1. use [this template](https://github.com/melodysdreamj/app_link_web_template), create new repository in your github account.
2. clone the repository to your local computer.
3. go to [cloudflare](https://dash.cloudflare.com/), login and select Workers & Pages > Overview > Create application > Pages Tap >
   Connect to Git > select the repository you just created. > Begin setup > Save and Deploy.
4. open cloned project, go to index.html file, replace the content with the following code.
- [your_scheme] -> your app scheme name. ex) myapp
- [your.app.package] -> your app package name. ex) com.example.myapp

#### 1.android part setting
5. get sha-256 fingerprint from your app
- if you want get **debug fingerprint on mac**, enter the following command in terminal.
   - if your computer not installed java, please install it first.
      - go to [install page](https://www.oracle.com/java/technologies/javase/jdk16-archive-downloads.html), download and install [macOS x64 Installer.]
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```
- if you want get **debug fingerprint on windows**, enter the following command in terminal.
   - if your computer not installed java, please install it first.
      - go to [install page](https://www.oracle.com/java/technologies/javase/jdk16-archive-downloads.html), download and install [Windows x64 Installer.]
      - go to settings > system > about > advanced system settings > environment variables > system variables > path > edit > new > paste the path.
         - ex) C:\Program Files\Java\jdk-16\bin
      - create new android project and run once to generate the debug.keystore file.
```bash
keytool -list -v -keystore "C:\Users\[UserName]\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```
- if you want get **release fingerprint**, create appbundle and upload to google play store, then you can find the sha-256 fingerprint in app signing section in google play console.
```bash
flutter build appbundle
```
6. replace [11:22:33:44:55:66...] in [.well-known/assetlinks.json] file with the sha-256 fingerprint you just got.
7. replace [your.package.name] in [.well-known/assetlinks.json] file with your app package name. ex) com.example.myapp

#### 2. ios part setting
8. replace [apple team id] in [.well-known/apple-app-site-association] file with your apple team id.
   - you can find your apple team id membership section in [apple developer account](https://developer.apple.com/account/).
9. replace [[app bundle id]] in [.well-known/apple-app-site-association] file with your app package name. ex) com.example.myapp


10. commit and push to github for update cloudflare pages.


### Android Configuration

1. add the app link and deep link code inside .MainActivity activity in android/app/src/main/AndroidManifest.xml file.
- replace [your_scheme] with your app scheme name. ex) myapp
- replace [your.app.package] with your app package name. ex) com.example.myapp
- replace [your.web.site] with your web site url that you created in step 5.
```xml
<!-- App Link -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" android:host="[your.web.site]" />
    <data android:scheme="https" android:host="[your.web.site]" />
</intent-filter>

<!-- Deep Link -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Add optional android:host to distinguish your app
         from others in case of conflicting scheme name -->
    <data android:scheme="[your_scheme]" android:host="[your.app.package]" />
    <!-- <data android:scheme="sample" /> -->
</intent-filter>
```

### iOS Configuration
1. open xcode in /ios/Runner.xcworkspace, go to Runner > Info > URL Types > add new URL Type. > add URL Schemes with your app scheme name. ex) sample
2. go to Signing & Capabilities > + Capability > Associated Domains > add new Associated Domain. > add your web site url with applinks prefix. ex) applinks:your.web.site
   * Warning
      * when write applinks prefix, do not add https:// prefix. ex) applinks:your.web.site
      * do not add / at the end of the url. ex) applinks:your.web.site

### MacOS Configuration
1. open xcode in /macos/Runner.xcworkspace, go to Runner > Info > URL Types > add new URL Type. > add URL Schemes with your app scheme name. ex) sample
2. go to Signing & Capabilities > + Capability > Associated Domains > add new Associated Domain. > add your web site url with applinks prefix. ex) applinks:your.web.site
   * Warning: when write applinks prefix, do not add https:// prefix. ex) applinks:your.web.site
   * do not add / at the end of the url. ex) applinks:your.web.site


## Usage
```dart 
EasyEventBus.on('receive_app_links_uri', (url) {
  print(url); // write your code here.
});
```
