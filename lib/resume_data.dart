/// Resume content, shared by the on-site resume page and the PDF generator
/// (tool/build_resume_pdf.py reads the same facts). Keep the two in step.
///
/// Figures here come from the GitHub Enterprise and github.com APIs rather than
/// memory, so they can be re-verified. Notably: Lamby and Crypteia are
/// rails-lambda projects Jeremiah contributed to, not ones he authored.
library;

class Bullet {
  final String lead;
  final String text;
  final bool sub;
  const Bullet(this.lead, this.text, {this.sub = false});
}

class Role {
  final String title;
  final String org;
  final String dates;
  final String blurb;
  final List<Bullet> bullets;
  const Role({
    required this.title,
    required this.org,
    required this.dates,
    required this.blurb,
    required this.bullets,
  });
}

const kResumeName = 'Jeremiah Parrack';
const kResumeTitle = 'Lead Software Engineer · Site Reliability / Platform';
const kResumeLocation = 'Atlanta, GA';

const kResumeSummary =
    'Software engineer with nine years building and operating production systems '
    'on AWS. I work at the seam between application code and the platform it runs '
    'on — shipping Rails, TypeScript, and Flutter applications, then automating '
    'the infrastructure, pipelines, and patching that keep them alive. Currently '
    'leading reliability and platform work across 311 repositories and 26 GitHub '
    'organizations at Cox Automotive, contributing to the Ruby and Rust '
    'open source that runs Rails on AWS Lambda, and publishing Flutter packages '
    'and apps of my own.';

const kRoles = <Role>[
  Role(
    title: 'Lead Software Engineer / SRE',
    org: 'Manheim — Cox Automotive',
    dates: 'May 2018 – Present',
    blurb: "World's largest wholesale auto auction: 145 auction sites across "
        'North America, Europe, Asia, and Australia.',
    bullets: [
      Bullet('Fleet-scale ownership: ',
          '4,000+ commits across 311 repositories in 26 GitHub organizations.'),
      Bullet('Automated dependency patching: ',
          'wrote Python tooling that scans a GitHub Enterprise org for outdated AWS service versions — Elastic Beanstalk solution stacks, AWS Glue versions, and Terraform releases — opens pull requests with the upgrade, flags severely outdated versions, and posts Slack notifications on a recurring schedule.'),
      Bullet('CI standardization: ',
          'migrated 100+ repositories onto shared, standardized GitHub Actions runners and upgraded reusable Terraform workflows org-wide, retiring per-team Jenkins pipelines.'),
      Bullet('Data platform: ',
          "built the Terraform and AWS Glue infrastructure behind DealShield's Assurance Protect Management System — ETL pipelines for fraud modeling, pending-reason analysis, problem-VIN detection, and inventory — plus Snowflake production and lower environments."),
      Bullet('Seller Tools: ',
          'Terraform for Seller Dashboard and API gateway infrastructure, plus sale-history and disclosure services.'),
      Bullet('Developer experience: ',
          'authored reusable pipeline templates for serverless apps, Angular modules, and npm packages, cutting pipeline definitions from hundreds of lines to roughly twenty so teams could own their own deploys.'),
      Bullet('Observability: ',
          'implemented logging, custom metrics, and dashboards that cut hours off production debugging; standardized alerting and secrets management on AWS Parameter Store across teams.'),
      Bullet('Governance: ',
          'onboarded workloads to the internal service catalog and authored Production Readiness Review documentation.'),
      Bullet('Enablement: ',
          'ran recurring talks and tutorials on Terraform, deployment ownership, and the release process; mentored engineers out of the apprenticeship program.'),
    ],
  ),
  Role(
    title: 'Founder / Lead Software Engineer',
    org: 'Jeremiah Parrack LLC',
    dates: 'Feb 2021 – Present',
    blurb: 'Independent consultancy: client engineering plus my own published apps.',
    bullets: [
      Bullet('Acuity PPM: ',
          'full-stack and platform engineering on a project-portfolio-management SaaS — a Rails API with a React/TypeScript frontend running on AWS Lambda. 215+ commits.'),
      Bullet('',
          'Serverless deploy automation, dedicated per-client production environments, and ephemeral review environments.',
          sub: true),
      Bullet('',
          'Lambda access to Postgres on RDS inside a VPC, Hasura, and SQS dead-letter queues with job retry.',
          sub: true),
      Bullet('',
          'New Relic, Sentry, Lambda Insights, log retention, and frontend caching.',
          sub: true),
      Bullet('',
          'Secure environment loading through Crypteia and Rails-on-Lambda through Lamby — both projects I contribute to upstream, so production experience feeds the libraries directly.',
          sub: true),
      Bullet('Own products: ',
          'four applications shipped to the App Store and Google Play.'),
      Bullet('FlowJitsu — ',
          'jiu-jitsu training tracker with an offline-first local database that syncs to the cloud. Over 1,000 users. Flutter, Firebase; iOS and Android.',
          sub: true),
      Bullet('Joyful Noise Tabs — ',
          'guitar tab and chord library for worship musicians, 6,000+ songs and over 600 users. Flutter, Firebase; iOS.',
          sub: true),
      Bullet('Pneuma Stream — ',
          'AI-narrated reading library that underlines each sentence as it is spoken. Flutter; iOS.',
          sub: true),
      Bullet('Smart Sprout — ',
          'AI-powered learning companion that adapts material to the learner. Flutter; iOS.',
          sub: true),
      Bullet('Delivery: ',
          'led a small delivery team, translated client requirements into scoped work, and built in-app subscriptions, release automation, and reusable logging and monitoring packages.'),
    ],
  ),
  Role(
    title: 'Software Engineer',
    org: 'Stord',
    dates: 'Sept 2017 – May 2018',
    blurb: 'Seed-stage logistics startup where I was the only developer. Stord '
        'has since raised \$777M and reached a \$3B valuation.',
    bullets: [
      Bullet('Built the first production platform: ',
          'the Ruby application and data model behind multi-warehouse inventory and product flow, letting brands see and move stock across every warehouse from one dashboard — including a ground-up redesign of the database it all sat on.'),
      Bullet('Owned the integration layer: ',
          'connected third-party warehouse management systems over SOAP and REST so inventory synced automatically between Stord and partner warehouses, which is what made a network of independent operators work as one.'),
      Bullet('Laid the engineering foundations: ',
          'introduced continuous integration, automated error alerting, and Elasticsearch, and set the unit and functional testing, debugging, security, and documentation practices the team scaled on.'),
    ],
  ),
];

const kOssGroups = <(String, List<Bullet>)>[
  (
    'Ruby & Rust — running Rails on AWS Lambda',
    [
      Bullet('Lamby — 625★: ',
          'Rails on AWS Lambda. Added Rack 3 support, carried the gem from Rails 7.1 to 8.1 and onto Ruby 3.4 / Bundler 4, and made shutdown exit gracefully on SIGTERM.'),
      Bullet('Crypteia — 77★: ',
          'Rust Lambda extension that preloads secure environment variables. Remediated GHSA-82j2-j2ch-gfr8 (a denial-of-service in rustls-webpki), upgraded the Rust toolchain, and fixed multi-architecture ARM releases.'),
      Bullet('Lambdakiq — 198★: ',
          'ActiveJob on SQS and Lambda. Modernized CI, added a release workflow, and moved the gem to Ruby 3.4.'),
      Bullet('jetpacker: ',
          'added a Tailwind install task, upgraded RuboCop and fixed the resulting offenses, and repaired the test suite in the Ruby on Jets asset pipeline.'),
    ]
  ),
  (
    'Flutter & Dart',
    [
      Bullet('authorize_net_plugin — pub.dev: ',
          'Flutter plugin I wrote and maintain, wrapping the native Android and iOS Authorize.Net payment SDKs behind one Dart API. Ten releases, still shipping.'),
      Bullet('flutter_template — 27★: ',
          'production Flutter starter — Riverpod state management, authentication flow, structured logging, and a test harness.'),
      Bullet('chewie — 2.1k★: ',
          'removed a spurious iOS simulator warning from the community video player used across the Flutter ecosystem.'),
      Bullet('flutter_chord: ',
          'added chorus-style passthrough to the line processor and support for comment directives in this chord parser and renderer.'),
    ]
  ),
];

const kSkills = <(String, String)>[
  ('Languages', 'Ruby, Dart, TypeScript, JavaScript, Python, Rust, SQL, Bash'),
  ('Frameworks', 'Rails, Flutter, React, Ruby on Jets, Hasura, Riverpod'),
  (
    'AWS',
    'Lambda, Glue, RDS, ECS, Elastic Beanstalk, SQS, SSM Parameter Store, VPC, CloudWatch, S3, IAM'
  ),
  ('Infrastructure', 'Terraform, AWS CDK, AWS SAM, Docker, Snowflake, Firebase'),
  (
    'CI/CD & Ops',
    'GitHub Actions, Jenkins, New Relic, Sentry, Lambda Insights, PostgreSQL, Redis, Elasticsearch'
  ),
];

const kEducation = (
  'Georgia State University',
  'B.S. Computer Science, concentration in Computer Software Systems',
  'May 2018',
);

/// Served straight out of web/, so it is a plain static download on Pages.
const kResumePdfPath = 'jeremiah-parrack-resume.pdf';
