# 🎧 Spotify Clone — Flutter

A cross-platform music player app built with **Flutter**, inspired by Spotify's UI and core listening experience. The app is built with a modern reactive stack (Riverpod), local persistence (Hive), and background-capable audio playback (`just_audio`), and it targets **Android, iOS, Web, Windows, Linux, and macOS** from a single codebase.

> ⚠️ This is a fan-made clone built for learning/portfolio purposes and is not affiliated with or endorsed by Spotify.

---

## ✨ Features

- 🔐 **Authentication** — Sign up / Sign in flow, with the user session cached locally (Hive) and validated remotely (HTTP)
- 🏠 **Home feed** — "Recently Played" and "Trending Songs" sections, Spotify-style
- 📚 **Library** — browse your added/favourited songs
- ▶️ **Full music player** — play/pause, next/previous, shuffle, repeat, seek bar, and a persistent **mini-player slab**
- 🎵 **Background playback** — keeps playing with lock-screen / notification controls via `just_audio_background`
- ❤️ **Favourites** — like songs from the player or the feed
- ➕ **Add Song screen** — pick an audio file and a cover image, preview the track's **waveform** (`audio_waveforms`), and pick a custom **accent color** for that song via a color wheel (`flex_color_picker`) — the mini-player and details screen adopt that color
- 💾 **Offline-friendly** — songs and user data are cached locally with `hive` / `hive_flutter` and `shared_preferences`
- ⚡ **Reactive state management** with `flutter_riverpod` + `riverpod_annotation` (code-generated providers/notifiers)
- 🧩 **Functional error handling** with `fpdart` (`Either`/`Failure` pattern)
- 📱 **Multi-platform support**: Android, iOS, Web, Windows, macOS, Linux

---

## 🛠️ Tech Stack

| Category            | Package(s) |
|----------------------|------------|
| Framework            | Flutter (Dart SDK `^3.12.0`) |
| State Management      | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` |
| Local Storage         | `hive`, `hive_flutter`, `shared_preferences` |
| Audio                 | `just_audio`, `just_audio_background`, `audio_waveforms` |
| Networking            | `http` |
| Functional Programming | `fpdart` |
| UI Utilities          | `flex_color_picker`, `dotted_border`, `file_picker` |
| Code Generation        | `build_runner`, `riverpod_generator`, `hive_generator` |
| Linting               | `flutter_lints` |

---

## 📁 Project Structure

The app follows a **feature-first architecture**: each feature (`auth`, `home`, …) owns its own `model` (data layer), `viewmodel` (state/business logic via Riverpod), and `view`/`views` (UI) folders. Shared code lives in `core/`.

```
spotify_clone/
│
├── android/ · ios/ · linux/ · macos/ · web/ · windows/   # Platform runners
│
├── assets/
│   └── images/                    # Icons used in the player UI (play/shuffle/repeat/library...)
│
├── screenshots/                   # App screenshots used in this README
│
├── lib/
│   ├── main.dart                  # App entry point
│   │
│   ├── core/                      # Shared code used across all features
│   │   ├── consts/
│   │   │   └── server_constants.dart      # API/base URL constants
│   │   ├── errorss/
│   │   │   └── failure.dart               # Common failure/error type (used with fpdart)
│   │   ├── functions/
│   │   │   ├── color_hex_conversion.dart  # Hex <-> Color helpers (flex_color_picker)
│   │   │   ├── pick_image.dart            # Image picking helper
│   │   │   ├── pick_song.dart             # Audio file picking helper (file_picker)
│   │   │   └── show_snack_bar.dart        # Shared SnackBar helper
│   │   ├── providers/
│   │   │   ├── current_song_notifier.dart     # Riverpod notifier: currently playing song
│   │   │   └── user_model_notifier.dart       # Riverpod notifier: current logged-in user
│   │   ├── theme/
│   │   │   ├── app_palette.dart           # App color palette
│   │   │   └── theme.dart                 # ThemeData setup
│   │   └── widgets/
│   │       ├── custom_text_form_field.dart
│   │       └── loader.dart
│   │
│   └── features/
│       ├── auth/                          # 🔐 Authentication feature
│       │   ├── model/
│       │   │   ├── models/user_model.dart
│       │   │   └── repos/
│       │   │       ├── auth_local_repo.dart   # Hive-based local persistence
│       │   │       └── auth_remote_repo.dart  # HTTP-based remote auth
│       │   ├── viewmodel/
│       │   │   └── auth_viewmodel.dart        # Riverpod AsyncNotifier for auth state
│       │   └── view/
│       │       ├── sign_in_view.dart
│       │       ├── sign_up_view.dart
│       │       └── widgets/
│       │           ├── auth_button.dart
│       │           ├── custom_text_button.dart
│       │           ├── sign_in_body.dart
│       │           └── sign_up_body.dart
│       │
│       └── home/                          # 🎵 Home / player / library feature
│           ├── model/
│           │   ├── models/
│           │   │   ├── favourite_song_model.dart
│           │   │   └── song_model.dart
│           │   └── repos/
│           │       ├── home_repo.dart         # Remote song fetching (HTTP)
│           │       └── local_home_repo.dart   # Local song caching (Hive)
│           ├── viewmodel/
│           │   └── home_viewmodel.dart        # Riverpod AsyncNotifier for songs/library
│           └── views/
│               ├── home_view.dart             # Home tab: Recently Played, Trending, mini-player
│               ├── add_song_view.dart         # Add/record a song, pick cover, waveform, color
│               ├── music_details_view.dart    # Full-screen player
│               └── widgets/
│                   ├── library_body.dart
│                   ├── music_slab.dart        # Mini-player bar
│                   ├── song_body.dart
│                   └── waveform_widget.dart   # audio_waveforms visualization
│
├── pubspec.yaml                   # Dependencies & asset declarations
└── analysis_options.yaml          # Lint rules
```

> Files ending in `.g.dart` (e.g. `auth_viewmodel.g.dart`) are **generated** by `build_runner`/`riverpod_generator`/`hive_generator` — don't edit them by hand, see [Development Notes](#-development-notes).

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.12.0` or newer)
- A configured emulator/simulator, or a physical device / browser / desktop target

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamadnafe14-arch/spotify-clone-flutter-.git
   cd spotify-clone-flutter-
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (required for Riverpod & Hive generated code)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```
   Or target a specific platform:
   ```bash
   flutter run -d chrome    # Web
   flutter run -d windows   # Windows
   flutter run -d macos     # macOS
   ```

---

## 🧪 Development Notes

- This project uses **code generation**. Whenever you modify a `@riverpod` provider or a `HiveType` model, re-run:
  ```bash
  dart run build_runner watch --delete-conflicting-outputs
  ```
- Static analysis rules are defined in `analysis_options.yaml` (based on `flutter_lints`).

---

## 📸 Screenshots

| Sign Up | Home Feed | Full Player |
|:---:|:---:|:---:|
| <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.37.jpeg" width="220"/> | <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.41.jpeg" width="220"/> | <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.38.jpeg" width="220"/> |

| Add Song (waveform + color picker) | Home Feed (dynamic accent color) | Background Playback |
|:---:|:---:|:---:|
| <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.40.jpeg" width="220"/> | <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.37 (2).jpeg" width="220"/> | <img src="screenshots/WhatsApp Image 2026-08-04 at 13.31.39.jpeg" width="220"/> |

> 📁 All screenshots live in [`screenshots/`](./screenshots). The folder currently has more raw images (`WhatsApp Image ...jpeg`) than shown above — for a cleaner README it's worth **renaming them** to descriptive names (e.g. `sign_in.jpeg`, `home.jpeg`, `player.jpeg`, `add_song.jpeg`, `library.jpeg`) and updating the paths here to match.

---

## 🗺️ Roadmap Ideas

- [ ] Playlist creation & management
- [ ] Search functionality
- [ ] Streaming from a remote music API/catalog (currently songs are user-added)
- [ ] Offline downloads
- [ ] Cross-device sync via cloud backend
- [ ] Unit / widget tests

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

MIT license was added.
---

## 🙋 Author

**Mohamad Nafe** — [@mohamadnafe14-arch](https://github.com/mohamadnafe14-arch)
