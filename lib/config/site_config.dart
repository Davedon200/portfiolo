class SiteConfig {
  static const name = 'Michael David';
  static const fullName = 'Michael David Chinaecherem';
  static const greeting = 'Hello, my name is';
  static const headline = 'Mobile Engineer · 2+ years · Lagos, Nigeria';
  static const homeEyebrow = 'MOBILE ARCHITECTURE · PLATFORM · SCALE';
  static const homeTitleLine1 = 'Software Engineer &';
  static const homeTitleLine2 = 'Senior Full stack';
  static const homeTitleLine3 = 'Mobile Developer';
  static const homeHeroBody =
      'I\'m Michael David, a Nigeria-based software developer. I manage mobile architecture, release governance, and delivery for a 1M-user app — leading a squad across a 30+ module Flutter codebase. 5 years building production iOS & Android, from offline-first data to release engineering.';
  static const homeAvailabilityLabel = 'Available for hire';
  static const homeAvailabilityTypes = 'Full-time · Fractional · Contract';
  static const homeHeroStats = <SiteStat>[
    SiteStat(value: '1M+', label: 'Users reached'),
    SiteStat(value: '99.9%', label: 'Crash-free rate'),
    SiteStat(value: '110+', label: 'Production releases'),
  ];
  static const roleLine =
      'I am a Mobile Engineer specializing in Flutter and React Native';
  static const introParagraphs = <String>[
    'Mobile Engineer with hands-on experience shipping Flutter and React Native apps — from Figma to production, including real-time logistics, digital banking features, API integrations, and clean state management.',
  ];

  static const email = 'Davemichael15@yahoo.com';
  static const whatsapp = '2348137298927';
  static const phone = '+2348074210369';
  static const phoneAlt = '+2348137298927';
  static const linkedin = 'https://www.linkedin.com/in/davedon200/';
  static const github = 'https://github.com/Davedon200';
  static const location = 'Lagos, Nigeria';
  static const resumeAsset = 'assets/docs/michael_david_resume.pdf';
  static const resumeFileName = 'Michael_David_Resume.pdf';
  static const calendlyUrl = 'https://calendly.com/davedon';

  static const aboutTitle = 'Professional Summary';
  static const aboutBody =
      'Mobile Engineer and Full Stack Engineer focused on Flutter, React Native, and backend delivery. I turn Figma designs into production-ready UIs, integrate REST APIs and payment gateways, and ship real-time features with WebSockets — including live shipment tracking and digital banking flows.\n\n'
      'At Loveworld Publishing I lead mobile and backend systems for media production. At Scelloo I shipped end-to-end mobile experiences with Bloc and Provider, including AI-driven features. At Polaris Bank I delivered Target Savings and Safe Lock with Dio and Provider, working closely with design and QA.';

  static const statsIntro =
      'A snapshot of experience shipping production mobile, web, and media products.';
  static const siteStats = <SiteStat>[
    SiteStat(value: '3+', label: 'Years in mobile'),
    SiteStat(value: '9+', label: 'Apps & products shipped'),
    SiteStat(value: '3', label: 'Production domains'),
    SiteStat(value: '2', label: 'Flutter certifications'),
  ];

  static const availabilityIntro =
      'Open to Flutter and React Native roles — full-time, contract, or freelance. Based in Lagos; remote and hybrid welcome. I typically reply within 24–48 hours.';
  static const availabilityOptions = <String>[
    'Full-time',
    'Contract',
    'Freelance',
    'Remote / hybrid',
  ];
  static const responseTime = 'Usually replies within 24–48 hours';

  static const experienceIntro =
      'Recent roles shipping products in media publishing, fintech, and logistics.';
  static const experiences = <SiteExperience>[
    SiteExperience(
      role: 'Backend Engineer & Mobile Lead',
      org: 'Loveworld Publishing · Lagos',
      period: 'Oct 2025 – Present',
      detail:
          'Cut deployment time from 72 hours to 50 minutes with GitHub Actions and Amazon S3. Delivered 5+ mobile/web, UI/UX, and AI projects. Built FastAPI microservices with Docker, MySQL, and PostgreSQL for an end-to-end media production workflow serving 100+ users hourly.',
      icon: 'movie',
    ),
    SiteExperience(
      role: 'Mobile Developer (Contract)',
      org: 'Polaris Bank · Lagos',
      period: 'Oct 2024 – Dec 2024',
      detail:
          'Integrated APIs for Target Savings and Safe Lock, managing state with Provider and Dio. Partnered with QA to identify and fix bugs, increasing application responsiveness by 100%.',
      icon: 'account_balance',
    ),
    SiteExperience(
      role: 'Senior Mobile Engineer',
      org: 'Scelloo · Lagos',
      period: 'Apr 2023 – Mar 2026',
      detail:
          'Shipped cross-platform apps that improved UI/UX and client satisfaction by 82%. Integrated AI chatbots and ML models, plus WebSocket live shipment and trip tracking. Led the team through Google services, payment gateways, Bloc, and Provider — cutting development cycles by 15%.',
      icon: 'work',
    ),
  ];

  static const skillsIntro =
      'Tools and patterns I use to ship Flutter, React Native, and backend systems.';
  static const skillGroups = <SiteSkillGroup>[
    SiteSkillGroup(
      title: 'Languages',
      items: ['Dart', 'JavaScript', 'Python', 'C++'],
      icon: 'code',
    ),
    SiteSkillGroup(
      title: 'Mobile',
      items: ['Flutter', 'Dart', 'React Native', 'Firebase', 'WebSockets'],
      icon: 'phone_iphone',
    ),
    SiteSkillGroup(
      title: 'Architecture',
      items: ['Bloc', 'Provider', 'GetX', 'Hooks', 'MVVM'],
      icon: 'architecture',
    ),
    SiteSkillGroup(
      title: 'APIs',
      items: ['REST APIs', 'Dio', 'Paystack'],
      icon: 'api',
    ),
  ];

  static const portfolioIntro =
      'Production work in banking, logistics, and media.';

  static const portfolioNavItems = <PortfolioNavItem>[
    PortfolioNavItem(label: 'Summary', sectionId: 'about'),
    PortfolioNavItem(label: 'Highlights', sectionId: 'stats'),
    PortfolioNavItem(label: 'Experience', sectionId: 'experience'),
    PortfolioNavItem(label: 'Skills', sectionId: 'skills'),
    PortfolioNavItem(label: 'Portfolio', sectionId: 'portfolio'),
    PortfolioNavItem(label: 'UI Challenges', sectionId: 'challenges'),
    PortfolioNavItem(label: 'Certifications', sectionId: 'achievements'),
    PortfolioNavItem(label: 'Testimonials', sectionId: 'testimonials'),
    PortfolioNavItem(label: 'Availability', sectionId: 'availability'),
    PortfolioNavItem(label: 'Contact', sectionId: 'contact'),
  ];

  static const challengesIntro =
      'Flutter animation and UI experiments — motion, 3D, and polished product surfaces.';
  static const uiChallenges = <UiChallenge>[
    UiChallenge(
      title: '3D Model',
      detail:
          'Interactive 3D character / product presentation built in Flutter.',
      imageAsset: 'assets/challenges/challenge_3d.gif',
      url: 'https://x.com/daveeilish/status/1891293267586687335?s=46',
    ),
    UiChallenge(
      title: 'MuleEx',
      detail:
          'Logistics UI motion — live tracking feel, status updates, and polished flows.',
      imageAsset: 'assets/challenges/challenge_muleex.gif',
      url: 'https://x.com/daveeilish/status/1891821883017855113?s=46',
    ),
    UiChallenge(
      title: 'Mich',
      detail:
          'UI challenge exploring expressive layout, motion, and brand-forward screens.',
      imageAsset: 'assets/challenges/challenge_mich.gif',
      url: 'https://x.com/daveeilish/status/1891293267586687335?s=46',
    ),
    UiChallenge(
      title: 'Crypto App',
      detail:
          'Crypto product UI challenge — dense data surfaces with clean interaction.',
      imageAsset: 'assets/challenges/challenge_crypto.gif',
      url: 'https://x.com/daveeilish/status/1891293267586687335?s=46',
    ),
  ];

  static const portfolioProjects = <PortfolioProject>[
    PortfolioProject(
      title: 'Vulte',
      detail:
          'Digital bank with 1M+ downloads. Implemented Safe Lock (10% interest p.a.) and Target Savings — personalized goals with a \$10 minimum deposit.',
      imageAsset: 'assets/projects/vulte/00_intro.jpg',
      images: [
        'assets/projects/vulte/00_intro.jpg',
        'assets/projects/vulte/01_home.jpg',
        'assets/projects/vulte/02_receipt.jpg',
      ],
      heightRatio: 1.15,
      tag: 'Dart · Flutter',
      category: ProjectCategory.production,
      metrics: '1M+ downloads · Safe Lock · Target Savings',
    ),
    PortfolioProject(
      title: 'MuleEx',
      detail:
          'Enterprise transportation and delivery platform. In-app alerts, payment gateways, and WebSockets for live shipment and trip updates between app and backend.',
      imageAsset: 'assets/projects/muleex/00_intro.jpg',
      images: [
        'assets/projects/muleex/00_intro.jpg',
        'assets/projects/muleex/01_login.jpg',
        'assets/projects/muleex/02_shipping_platform.jpg',
        'assets/projects/muleex/03_payment.jpg',
        'assets/projects/muleex/04_hub.jpg',
        'assets/projects/muleex/05_signup.jpg',
        'assets/projects/muleex/06_quote.jpg',
      ],
      heightRatio: 1.15,
      tag: 'Dart · Flutter',
      category: ProjectCategory.production,
      metrics: 'WebSockets · Payments · Live tracking',
    ),
    PortfolioProject(
      title: 'MediaFlow',
      detail:
          'Role-based platform for production teams to submit content, review collaboratively, approve for broadcast, and track performance against goals — lifting productivity, transparency, and performance by 89%.',
      imageAsset: 'assets/projects/mediaflow/00_intro.jpg',
      videoUrl:
          'https://drive.google.com/file/d/1VYF9dvXgn5P4qpEsISOLzVl3MfMHSBBe/preview',
      heightRatio: 0.72,
      tag: 'Python · FastAPI',
      category: ProjectCategory.production,
      metrics: 'Media workflow · 89% productivity',
    ),
    PortfolioProject(
      title: 'Rhapsody TV',
      detail:
          'Designed and developed the cross-platform mobile version of Rhapsody TV for Rhapsody of Realities.',
      imageAsset: 'assets/projects/rhapsody_tv/00_intro.jpg',
      images: [
        'assets/projects/rhapsody_tv/00_intro.jpg',
        'assets/projects/rhapsody_tv/01_splash.jpg',
        'assets/projects/rhapsody_tv/02_discover.jpg',
        'assets/projects/rhapsody_tv/03_discover_live.jpg',
        'assets/projects/rhapsody_tv/04_categories.jpg',
        'assets/projects/rhapsody_tv/05_schedule.jpg',
        'assets/projects/rhapsody_tv/06_live.jpg',
        'assets/projects/rhapsody_tv/07_vod.jpg',
        'assets/projects/rhapsody_tv/08_travels.jpg',
        'assets/projects/rhapsody_tv/09_profile.jpg',
      ],
      heightRatio: 1.15,
      tag: 'Flutter · Dart',
      category: ProjectCategory.production,
      metrics: 'Cross-platform · Media',
    ),
    PortfolioProject(
      title: 'Rhapsody Media Network',
      detail:
          'Portal that unifies creatives, designers, video editors, writers, and media professionals into one structured global system focused on excellence, consistency, and impact.',
      imageAsset: 'assets/projects/rhapsody_media_network/00_intro.jpg',
      images: [
        'assets/projects/rhapsody_media_network/00_intro.jpg',
        'assets/projects/rhapsody_media_network/01_about.jpg',
        'assets/projects/rhapsody_media_network/02_library.jpg',
      ],
      heightRatio: 0.72,
      tag: 'Web · Backend',
      category: ProjectCategory.production,
      metrics: 'Creatives portal · Global media',
    ),
  ];

  static const testimonialsIntro =
      'What collaborators notice when we ship mobile products together.';
  static const testimonials = <SiteTestimonial>[
    SiteTestimonial(
      name: 'Victor Nike',
      role: 'Graduate Research Assistant @Florida A&M University',
      quote:
          'Michael is a great developer, he is dependable, takes ownership of his work, and is always willing to step up, solve difficult problems, and support the team. I would confidently recommend for any Senior Mobile Developer role.',
      rating: 5,
    ),
    SiteTestimonial(
      name: 'Emmanuel Sunday',
      role: 'Staff Engineer at Heartbeat Medical',
      quote:
          'I\'ve mentored Michael. I can admit he is a great problem solver and an out-of-box thinker. He likes challenges and he has a passion for the edge of techs. He is also a great and professional student. I learned many things from him.',
      rating: 5,
    ),
  ];

  static const achievementsIntro =
      'Education and formal training that backs Flutter architecture, state management, and data work.';
  static const portfolioAchievements = <SiteAchievement>[
    SiteAchievement(
      year: 'Dec 2024',
      title: 'Flutter Bloc Essential Course',
      detail:
          'Udemy — Cubit/Bloc, BlocProvider, listeners, RepositoryProvider, and StreamSubscription patterns. Credential: ude.my/UC-aa5757cd-4dd5-4b51-be96-61112fe3638c',
    ),
    SiteAchievement(
      year: 'Jun 2024',
      title: 'Flutter Advanced — Clean Architecture with MVVM',
      detail:
          'Udemy (UC-98aeb935-49ac-4be9-a305-eb448c71d934) — Dependency Injection, Routes Manager, MVVM, API caching, mock/stub APIs, JSON serialization, Stream/RX Dart.',
    ),
    SiteAchievement(
      year: 'Education',
      title: 'BSc. Physics and Astronomy',
      detail: 'Undergraduate degree listed on CV — Physics and Astronomy.',
    ),
    SiteAchievement(
      year: 'Education',
      title: 'Masters in Data Computing',
      detail: 'Graduate training in data computing, supporting AI and backend delivery.',
    ),
  ];

  static const contactIntro =
      'Based in $location. Open to Flutter and React Native roles — email, WhatsApp, or book a call via Calendly.';

  static const sections = <SiteSection>[];
}

enum ProjectCategory { production, personal }

class SiteSection {
  const SiteSection({
    required this.path,
    required this.eyebrow,
    required this.title,
    required this.lead,
    required this.navLabel,
    required this.achievements,
    required this.projects,
  });

  final String path;
  final String eyebrow;
  final String title;
  final String lead;
  final String navLabel;
  final List<SiteAchievement> achievements;
  final List<SiteProject> projects;
}

class SiteStat {
  const SiteStat({required this.value, required this.label});

  final String value;
  final String label;
}

class SiteAchievement {
  const SiteAchievement({
    required this.year,
    required this.title,
    required this.detail,
  });

  final String year;
  final String title;
  final String detail;
}

class SiteProject {
  const SiteProject({
    required this.title,
    required this.detail,
    required this.tag,
    this.url,
  });

  final String title;
  final String detail;
  final String tag;
  final String? url;
}

class PortfolioProject {
  const PortfolioProject({
    required this.title,
    required this.detail,
    required this.imageAsset,
    this.images = const [],
    this.videoUrl,
    this.url,
    this.heightRatio = 1.0,
    this.tag,
    this.category = ProjectCategory.personal,
    this.metrics,
  });

  final String title;
  final String detail;
  final String imageAsset;
  final List<String> images;
  final String? videoUrl;
  final String? url;
  final double heightRatio;
  final String? tag;
  final ProjectCategory category;
  final String? metrics;

  List<String> get galleryImages =>
      images.isNotEmpty ? images : <String>[imageAsset];
}

class PortfolioNavItem {
  const PortfolioNavItem({required this.label, this.path, this.sectionId});

  final String label;
  final String? path;
  final String? sectionId;
}

class SiteTestimonial {
  const SiteTestimonial({
    required this.name,
    required this.quote,
    required this.rating,
    this.role,
    this.company,
    this.imageAsset,
  });

  final String name;
  final String quote;
  final int rating;
  final String? role;
  final String? company;
  final String? imageAsset;
}

class SiteSkillGroup {
  const SiteSkillGroup({
    required this.title,
    required this.items,
    this.icon = 'code',
  });

  final String title;
  final List<String> items;
  final String icon;
}

class SiteExperience {
  const SiteExperience({
    required this.role,
    required this.org,
    required this.period,
    required this.detail,
    this.icon = 'work',
  });

  final String role;
  final String org;
  final String period;
  final String detail;
  final String icon;
}

class UiChallenge {
  const UiChallenge({
    required this.title,
    required this.detail,
    required this.imageAsset,
    this.url,
  });

  final String title;
  final String detail;
  final String imageAsset;
  final String? url;
}
