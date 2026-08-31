# Michael David

Flutter Web personal portfolio for Michael David — Mobile Engineer (Flutter & React Native).

## Structure

```text
lib/
  main.dart                 # entry
  app.dart                  # MaterialApp + theme
  config/site_config.dart   # content + contact
  theme/app_colors.dart
  router/app_router.dart
  pages/                    # home + portfolio
  widgets/                  # logo, social, header, portrait
assets/
  images/                   # brand logo + portrait
  icons/                    # platform SVGs
  projects/                 # portfolio screenshots
  challenges/               # UI challenge GIFs
  docs/                     # resume PDF
```

## Routes

- `/` — homepage
- `/projects` — portfolio CV (supports section deep links, e.g. `/projects#experience`)

## Run

```bash
cd ~/Desktop/projects/michael_david
flutter run -d chrome
```

Edit contact details and content in `lib/config/site_config.dart`.
