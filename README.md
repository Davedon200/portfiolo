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

## Production build

```bash
flutter build web --release --tree-shake-icons
```

Heavy media (challenge GIFs, resume PDF) is served from `web/assets/` and is not bundled into the initial Flutter asset payload. Fonts are bundled locally (no runtime Google Fonts fetch).

Deploy the contents of `build/web/` (Vercel uses `vercel.json` cache headers).
