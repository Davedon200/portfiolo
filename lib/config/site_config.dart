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
      'Mobile Engineer focused on Flutter and React Native. I turn Figma designs into responsive, production-ready UIs, integrate REST APIs and payment gateways, and ship real-time features with WebSockets — including live shipment tracking and digital banking flows.\n\n'
      'At Scelloo I build end-to-end mobile experiences with Bloc and Provider; at Polaris Bank I delivered Target Savings and Safe Lock features with Dio and Provider, working closely with design and QA.';

  static const statsIntro =
      'A snapshot of experience shipping production mobile products.';
  static const siteStats = <SiteStat>[
    SiteStat(value: '2+', label: 'Years in mobile'),
    SiteStat(value: '6+', label: 'Apps & products shipped'),
    SiteStat(value: '2', label: 'Production domains'),
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
      'Recent roles shipping mobile products in fintech and logistics.';
  static const experiences = <SiteExperience>[
    SiteExperience(
      role: 'Software Engineer',
      org: 'Scelloo · Lekki, Lagos',
      period: 'Apr 2023 – Present',
      detail:
          'Shipped production UIs from Figma handoffs and delivered real-time WebSocket tracking for live shipments and trip status. Integrated backend APIs, Google services, and Paystack payment flows with Bloc and Provider state management.',
      icon: 'work',
    ),
    SiteExperience(
      role: 'Software Developer (Contract)',
      org: 'Polaris Bank · Ikeja, Lagos',
      period: 'Oct 2024 – Dec 2024',
      detail:
          'Delivered Target Savings and Safe Lock banking features to production using Provider and Dio. Built responsive Flutter UI from design specs and partnered with QA to improve responsiveness and release quality.',
      icon: 'account_balance',
    ),
  ];

  static const skillsIntro =
      'Tools and patterns I use to ship reliable Flutter and React Native apps.';
  static const skillGroups = <SiteSkillGroup>[
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
      title: 'APIs & Delivery',
      items: ['REST APIs', 'Dio', 'Paystack', 'Figma handoff', 'Git', 'Jira'],
      icon: 'api',
    ),
  ];

  static const portfolioIntro =
      'Production work in banking and logistics, plus personal open-source builds.';

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
          'Fully digital bank on smart devices. Built Safe Lock (10% interest p.a.) and Target Savings (goals from \$10 minimum).',
      imageAsset: 'assets/projects/project_1.png',
      heightRatio: 1.2,
      tag: 'Dart · Flutter',
      category: ProjectCategory.production,
      metrics: 'Banking · Safe Lock · Target Savings',
    ),
    PortfolioProject(
      title: 'MuleEx',
      detail:
          'Enterprise transportation and delivery. In-app alerts, Paystack payments, and WebSocket live shipment/trip updates.',
      imageAsset: 'assets/projects/project_2.png',
      heightRatio: 0.95,
      tag: 'Dart · Flutter',
      category: ProjectCategory.production,
      metrics: 'WebSockets · Paystack · Live tracking',
    ),
    PortfolioProject(
      title: 'Ham-Chat',
      detail:
          'Messaging app with a strong focus on clean UI and conversation flow.',
      imageAsset: 'assets/projects/project_3.png',
      heightRatio: 1.05,
      url: 'https://github.com/Davedon200/Ham-Chat',
      tag: 'Flutter',
      category: ProjectCategory.personal,
    ),
    PortfolioProject(
      title: '3D Character Store',
      detail:
          'Service store that displays products on a 3D character experience.',
      imageAsset: 'assets/projects/project_4.png',
      heightRatio: 1.15,
      url: 'https://github.com/Davedon200/3d_character-app',
      tag: 'Flutter',
      category: ProjectCategory.personal,
    ),
    PortfolioProject(
      title: 'Decide App',
      detail:
          'Decision helper — spin when you’re unsure and get a clear nudge.',
      imageAsset: 'assets/projects/project_5.png',
      heightRatio: 0.88,
      url: 'https://github.com/Davedon200/Decide_App',
      tag: 'Flutter',
      category: ProjectCategory.personal,
    ),
    PortfolioProject(
      title: 'Hives',
      detail: 'Sound utility giving quick access to tonic solfa in one tap.',
      imageAsset: 'assets/projects/project_6.png',
      heightRatio: 1.0,
      url: 'https://github.com/Davedon200/Hives',
      tag: 'Flutter',
      category: ProjectCategory.personal,
    ),
  ];

  static const testimonialsIntro =
      'What collaborators notice when we ship mobile products together.';
  static const testimonials = <SiteTestimonial>[
    SiteTestimonial(
      name: 'Product Collaborator',
      role: 'Product Manager',
      company: 'Logistics · Lagos',
      quote:
          'Michael turns complex Flutter requirements into reliable, real-time experiences — clear communication from design handoff to release.',
      rating: 5,
    ),
    SiteTestimonial(
      name: 'Engineering Peer',
      role: 'Mobile Engineer',
      company: 'Fintech',
      quote:
          'Strong ownership with Bloc/Provider architecture, thorough API work, and a steady partnership with design and QA.',
      rating: 5,
    ),
  ];

  static const achievementsIntro =
      'Formal training that backs day-to-day Flutter architecture and state management.';
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
    this.url,
    this.heightRatio = 1.0,
    this.tag,
    this.category = ProjectCategory.personal,
    this.metrics,
  });

  final String title;
  final String detail;
  final String imageAsset;
  final String? url;
  final double heightRatio;
  final String? tag;
  final ProjectCategory category;
  final String? metrics;
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
