plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // This connects your app to the google-services.json file
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.tradenest"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Firebase 3.0+ requires Java 17
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.tradenest"
        
        // 🔥 CRITICAL: Google Sign-In requires minSdk 21 or higher
        minSdk = flutter.minSdkVersion 
        
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Import the Firebase BoM (Bill of Materials) for version consistency
    implementation(platform("com.google.firebase:firebase-bom:33.1.0"))
    implementation("com.google.firebase:firebase-analytics")
    
    // Add multidex if you hit the 64k method limit (common with Firebase)
    implementation("androidx.multidex:multidex:2.0.1")
}

flutter {
    source = "../.."
}
