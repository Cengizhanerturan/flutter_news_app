**[Türkçe](#turkce) | [English](#english)**

# <a name="turkce"></a>Flutter ile Yazılmış Haber Uygulaması

Flutter Haber Uygulaması, kullanıcıların en güncel haberleri keşfedebileceği, favori haberlerini kaydedebileceği ve kişiselleştirilmiş ayarlarını yönetebileceği modern bir arayüze sahip, state management ve routing için GetX kullanılan bir mobil uygulamadır. Uygulama, kullanıcı deneyimini ve etkileşimini artırmak için çeşitli özellikler sunmaktadır.

## Özellikler

- **GetX ile State Management ve Routing**
    - Uygulamanın durum yönetimi ve sayfa geçişleri GetX ile sağlanmaktadır.
- **Firebase Authentication**
    - Kullanıcıların kayıt, giriş ve e-posta doğrulama işlemleri Firebase Authentication ile yönetilir.
- **Firebase Firestore**
    - Kullanıcı bilgileri (isim, soyisim, e-posta) Firestore'da saklanır ve güncellenebilir.
- **Haber Verileri**
    - Haberler [NewsAPI](https://newsapi.org/) üzerinden alınır ve `dio` paketi ile çekilir.
- **Favori Haberler**
    - Kullanıcılar favori haberlerini kaydedebilir ve favoriler listesinden yönetebilir.
- **Haber Arama Sistemi**
    - Haberler arasında anahtar kelime ile arama yapılabilir.
- **Kategorize Edilmiş Haberler**
    - Haberler kategori bazında filtrelenebilir ve tabbar ile görüntülenebilir.
- **Açık & Koyu Mod**
    - Kullanıcı tercihlerine göre tema değiştirilebilir.
- **Responsive Tasarım**
    - Farklı ekran boyutlarına uyumlu arayüz.
- **Animasyonlar**
    - Lottie animasyonları ile zenginleştirilmiş kullanıcı deneyimi.
- **Webview ile Haber Detayı**
    - Haber detayları uygulama içi webview ile gösterilir.

## APK Dosyası

[APK Dosyasını indir](https://drive.google.com/file/d/10NV2DAhAOwNo2e9hSELKiJN6zF_y60nf/view?usp=sharing)

## Kullanılan Teknolojiler ve Paketler

 Paket İsmi              | Versiyon 
-------------------------|----------
 Flutter                 | >=3.7.2
 get                     | 4.6.5
 get_storage             | 2.0.3
 dio                     | 5.8.0+1
 firebase_core           | 3.13.1
 firebase_auth           | 5.5.4
 cloud_firestore         | 5.6.8
 cached_network_image    | 3.4.1
 responsive_sizer        | 3.3.1
 lottie                  | 3.3.1
 webview_flutter         | 4.13.0
 intl                    | 0.20.2
 equatable               | 2.0.7
 auto_size_text          | 3.0.0
 skeleton_text           | 3.0.1
 expandable_page_view    | 1.0.17
 cupertino_icons         | 1.0.8

## Kurulum

1. **Projeyi klonlayın**

   ```bash
   git clone https://github.com/cengizhanerturan/flutter_news_app.git
   cd flutter_news_app
   ```

2. **Gerekli bağımlılıkları yükleyin**

   ```bash
   flutter pub get
   ```

3. **API anahtarınızı alın ve ilgili dosyaya ekleyin**

   - `lib/core/constants/api_constants.dart` dosyasındaki `API_KEY` alanına kendi NewsAPI anahtarınızı ekleyin.

   ```dart
   const String API_KEY = 'your_api_key';
   ```

4. **Projeyi çalıştırın**

   ```bash
   flutter run
   ```

## Uygulama Tanıtım Videosu (Youtube)

<p>Kayıt, giriş, e-posta değiştirme, şifre değiştirme ve kullanıcı bilgileri değiştirme bölümleri, YouTube kurallarına uymadığı gerekçesiyle videodan çıkartılmıştır.</p>

[Uygulama tanıtım videosunu youtube'dan izle.](https://youtube.com/shorts/6MVdNm9iYk0)

## Ekran Görüntüleri

<p>Aşağıda uygulamanın açık ve koyu mod olarak ekran görüntülerini bulabilirsiniz</p>

## Açık Mod

### 1. Giriş ve Kayıt Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/auth-1.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/auth-2.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>

### 2. Anasayfa, Keşfet, Favoriler ve Arama Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/home.png" alt="Anasayfa, Keşfet, Favoriler ve Arama" style="max-width: 100%;" /></a>

### 3. Haber Detay Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/details.png" alt="Haber Detay" style="max-width: 100%;" /></a>

### 4. Ayarlar Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/settings.png" alt="Ayarlar" style="max-width: 100%;" /></a>

## Koyu Mod

### 1. Giriş ve Kayıt Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/auth-1.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/auth-2.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>

### 2. Anasayfa, Keşfet, Favoriler ve Arama Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/home.png" alt="Anasayfa, Keşfet, Favoriler ve Arama" style="max-width: 100%;" /></a>

### 3. Haber Detay Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/details.png" alt="Haber Detay" style="max-width: 100%;" /></a>

### 4. Ayarlar Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/settings.png" alt="Ayarlar" style="max-width: 100%;" /></a>

<br><br>

# <a name="english"></a>News Application Written in Flutter

Flutter News Application is a mobile app with a modern interface where users can discover the latest news, save their favorite articles, and manage personalized settings. GetX is used for state management and routing. The app includes various features to enhance user experience and engagement.

## Features

- **State Management and Routing with GetX**
    - State management and page navigation are handled using GetX.
- **Firebase Authentication**
    - User registration, login, and email verification are managed using Firebase Authentication.
- **Firebase Firestore**
    - User information (name, surname, email) is stored and updated using Firestore.
- **News Data**
    - News articles are fetched from [NewsAPI](https://newsapi.org/) using the `dio` package.
- **Favorite News**
    - Users can save and manage their favorite news articles.
- **News Search System**
    - Search functionality for news articles by keywords.
- **Categorized News**
    - News articles are organized by categories and can be displayed using a tab bar.
- **Light & Dark Mode**
    - Users can switch between light and dark themes.
- **Responsive Design**
    - UI adapts to different screen sizes.
- **Animations**
    - Enhanced user experience with Lottie animations.
- **News Details via Webview**
    - News details are displayed in-app using webview.

## APK File

[Download the APK File](https://drive.google.com/file/d/10NV2DAhAOwNo2e9hSELKiJN6zF_y60nf/view?usp=sharing)

## Technologies and Packages Used

 Package Name             | Version 
-------------------------|---------
 Flutter                 | >=3.7.2
 get                     | 4.6.5
 get_storage             | 2.0.3
 dio                     | 5.8.0+1
 firebase_core           | 3.13.1
 firebase_auth           | 5.5.4
 cloud_firestore         | 5.6.8
 cached_network_image    | 3.4.1
 responsive_sizer        | 3.3.1
 lottie                  | 3.3.1
 webview_flutter         | 4.13.0
 intl                    | 0.20.2
 equatable               | 2.0.7
 auto_size_text          | 3.0.0
 skeleton_text           | 3.0.1
 expandable_page_view    | 1.0.17
 cupertino_icons         | 1.0.8

## Setup Instructions

1. **Clone the project**

   ```bash
   git clone https://github.com/cengizhanerturan/flutter_news_app.git
   cd flutter_news_app
   ```

2. **Install the required dependencies**

   ```bash
   flutter pub get
   ```

3. **Obtain your API key and add it to the relevant file**

   - Add your NewsAPI key to `lib/core/constants/api_constants.dart` as follows:

   ```dart
   static const String API_KEY = 'your_api_key';
   ```

4. **Run the project**

   ```bash
   flutter run
   ```

## Application Demo Video (Youtube)

<p>The registration, login, email change, password change, and user information update sections have been removed from the video due to non-compliance with YouTube policies.</p>

[Watch the application demo video on YouTube.](https://youtube.com/shorts/6MVdNm9iYk0)

## Screenshots

<p>Below are screenshots of the application in both light and dark modes.</p>

## Light Mode

### 1. Login and Sign-up Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/auth-1.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/auth-2.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>

### 2. Home, Discover, Favorites and Search Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/home.png" alt="Home, Discover, Favorites and Search" style="max-width: 100%;" /></a>

### 3. News Detail Screen

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/details.png" alt="News Detail" style="max-width: 100%;" /></a>

### 4. Settings Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/light/settings.png" alt="Settings" style="max-width: 100%;" /></a>

## Dark Mode

### 1. Login and Sign-up Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/auth-1.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/auth-2.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>

### 2. Home, Discover, Favorites and Search Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/home.png" alt="Home, Discover, Favorites and Search" style="max-width: 100%;" /></a>

### 3. News Detail Screen

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/details.png" alt="News Detail" style="max-width: 100%;" /></a>

### 4. Settings Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app/blob/main/assets/screenshots/dark/settings.png" alt="Settings" style="max-width: 100%;" /></a>
