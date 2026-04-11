# ─── Flutter ────────────────────────────────────────────
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# ─── Google Play Core (deferred components) ─────────────
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# ─── ExoPlayer / Media3 (used by just_audio) ───────────
-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**
-keep class androidx.media3.** { *; }
-dontwarn androidx.media3.**

# ─── just_audio ─────────────────────────────────────────
-keep class com.ryanheise.just_audio.** { *; }
-dontwarn com.ryanheise.just_audio.**

# ─── audio_session ──────────────────────────────────────
-keep class com.ryanheise.audio_session.** { *; }
-dontwarn com.ryanheise.audio_session.**

# ─── audioplayers ───────────────────────────────────────
-keep class xyz.luan.audioplayers.** { *; }
-dontwarn xyz.luan.audioplayers.**

# ─── Firebase ───────────────────────────────────────────
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# ─── flutter_local_notifications ────────────────────────
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# ─── Kotlin ─────────────────────────────────────────────
-keep class kotlin.** { *; }
-dontwarn kotlin.**
-keep class kotlinx.** { *; }
-dontwarn kotlinx.**

# ─── General ────────────────────────────────────────────
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-dontwarn javax.annotation.**
