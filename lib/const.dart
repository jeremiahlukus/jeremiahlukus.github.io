// ─── Links ───────────────────────────────────────────────────────────────────

const kGithubUrl = 'https://github.com/jeremiahlukus/';
const kLinkedInUrl = 'https://www.linkedin.com/in/jeremiahlukus/';
const kResumeUrl =
    'https://docs.google.com/document/d/104vzbtyoHl3syc6PHHk4KlmcbtloF76mo7jhL-HDcio/edit';
const kEmailAddress = 'jeremiahlukus1@gmail.com';

// ─── Hero facts table ────────────────────────────────────────────────────────

const kFacts = <(String, String)>[
  ('ROLE', 'Lead Software Engineer'),
  ('COMPANY', 'Manheim / Cox Automotive'),
  ('FOCUS', 'SRE · DevOps · Platform'),
  ('BUILDS WITH', 'Flutter · Ruby · Rust · AWS'),
  ('SHIPPED', 'App Store · Google Play'),
  ('STATUS', 'Open to freelance work'),
];

// ─── Selected work ───────────────────────────────────────────────────────────

/// `role` is deliberately explicit. Lamby and Crypteia are Custom Ink projects
/// that Jeremiah contributed to — not ones he authored — and the site should
/// say so plainly, because anyone can check in ten seconds.
class Work {
  final String name;
  final String blurb;
  final String role;
  final String meta;

  /// (label, url) pairs. Empty for work with no public listing yet — the row
  /// then renders as plain text rather than a dead link.
  final List<(String, String)> links;

  const Work(this.name, this.blurb, this.role, this.meta, this.links);
}

const kWork = <Work>[
  Work(
    'FlowJitsu',
    'Jiu-jitsu training tracker. Session logging, practice plans, technique '
        'libraries, and belt progression, with an offline-first local database '
        'that syncs to the cloud.',
    'Author',
    'Flutter · Firebase · iOS + Android',
    [
      ('App Store', 'https://apps.apple.com/us/app/flowjitsu/id6757253111'),
      (
        'Google Play',
        'https://play.google.com/store/apps/details?id=com.jparrack.flowjitsu'
      ),
    ],
  ),
  Work(
    'Joyful Noise Tabs',
    'Guitar tab and chord library for worship musicians, with a catalog of '
        'more than 6,000 songs, favorites, and offline access.',
    'Author',
    'Flutter · Firebase · iOS',
    [
      (
        'App Store',
        'https://apps.apple.com/us/app/joyful-noise-tabs/id6443610160'
      ),
    ],
  ),
  Work(
    'Pneuma Stream',
    'A curated library of books with AI-narrated audio that underlines each '
        'sentence as it is spoken and autoscrolls as you listen.',
    'Author',
    'Flutter · iOS',
    // Points at the developer page until the app clears review and has its own
    // id — swap in the direct listing URL then.
    [('App Store', 'https://apps.apple.com/us/developer/jeremiah-parrack/id1376363500')],
  ),
  Work(
    'Acuity PPM',
    'Ongoing DevOps and infrastructure work for a project portfolio '
        'management platform.',
    'DevOps',
    'Client engagement · AWS',
    [('acuityppm.com', 'https://acuityppm.com/')],
  ),
  Work(
    'Lamby',
    'Runs Rails applications on AWS Lambda by bridging Rack and the Lambda '
        'event payload.',
    'Contributor',
    'Ruby · 625 stars',
    [('GitHub', 'https://github.com/customink/lamby')],
  ),
  Work(
    'Crypteia',
    'Rust Lambda extension that preloads secure environment variables from SSM '
        'into any runtime or container.',
    'Contributor',
    'Rust · 77 stars',
    [('GitHub', 'https://github.com/customink/crypteia')],
  ),
  Work(
    'flutter_template',
    'Production Flutter starter: Riverpod state management, authentication '
        'flow, structured logging, and a test harness.',
    'Author',
    'Dart · 27 stars',
    [('GitHub', 'https://github.com/jeremiahlukus/flutter_template')],
  ),
];

// ─── About ───────────────────────────────────────────────────────────────────

const kAboutParagraphs = <String>[
  "I'm a lead software engineer with a decade of experience building production "
      'systems. At Manheim I lead SRE and DevOps work across onshore and '
      'offshore teams.',
  'I contribute to open source across Ruby, Rust, and Flutter — including Lamby, '
      'the Rails-on-Lambda integration, and Crypteia, a Rust Lambda extension '
      'for preloading secure environment variables. I maintain my own projects '
      'alongside that, and work heavily with AWS CDK and SAM in production.',
  'Outside of that I ship my own apps to the App Store and Google Play, and take '
      'on freelance development and consulting work — currently ongoing DevOps '
      'and infrastructure support for Acuity PPM.',
];

const kServices = <String>[
  'Mobile app development, end to end',
  'Web application development',
  'Infrastructure and DevOps',
  'System architecture design',
  'AWS cost optimization',
  'Technical consulting',
];

// ─── Stack ───────────────────────────────────────────────────────────────────

const kStack = <(String, List<String>)>[
  ('MOBILE', ['Flutter', 'Dart', 'iOS', 'Android']),
  ('BACKEND', ['Ruby on Rails', 'Node.js', 'TypeScript', 'REST APIs']),
  ('CLOUD & DEVOPS', ['AWS', 'CDK', 'SAM', 'Docker', 'Terraform', 'CI/CD']),
  ('DATA', ['Firebase', 'PostgreSQL', 'Redis', 'SQLite']),
];
