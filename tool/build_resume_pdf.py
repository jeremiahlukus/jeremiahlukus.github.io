"""Renders web/jeremiah-parrack-resume.pdf.

Uses the same fonts and palette as the site (assets/fonts) so the downloaded
resume matches the page it came from. Content mirrors lib/resume_data.dart —
change both together.

    uvx --from reportlab python3 tool/build_resume_pdf.py
"""
import os
from reportlab.lib.pagesizes import LETTER
from reportlab.lib.units import inch
from reportlab.lib.colors import HexColor
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (
    BaseDocTemplate, Frame, PageTemplate, Paragraph, Spacer, Table, TableStyle,
    KeepTogether, HRFlowable,
)
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_LEFT, TA_RIGHT

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONTS = os.path.join(ROOT, "assets", "fonts")
OUT = os.path.join(ROOT, "web", "jeremiah-parrack-resume.pdf")

# Print palette: same hues as the site, darkened for paper legibility.
INK = HexColor("#1A1714")
BODY = HexColor("#3A342E")
MUTE = HexColor("#6E665D")
LINE = HexColor("#CFC7BC")
AMBER = HexColor("#9A6A1E")
RUST = HexColor("#8A4A2A")

pdfmetrics.registerFont(TTFont("Serif", f"{FONTS}/InstrumentSerif-Regular.ttf"))
pdfmetrics.registerFont(TTFont("Sans", f"{FONTS}/IBMPlexSans-Regular.ttf"))
pdfmetrics.registerFont(TTFont("SansB", f"{FONTS}/IBMPlexSans-SemiBold.ttf"))
pdfmetrics.registerFont(TTFont("Mono", f"{FONTS}/IBMPlexMono-Regular.ttf"))
pdfmetrics.registerFont(TTFont("MonoM", f"{FONTS}/IBMPlexMono-Medium.ttf"))

# Register the family so <b> resolves to the SemiBold face. A bare
# <font name="SansB"> tag falls back silently and drags in Helvetica.
pdfmetrics.registerFontFamily("Sans", normal="Sans", bold="SansB",
                              italic="Sans", boldItalic="SansB")

def ps(name, **kw):
    kw.setdefault("alignment", TA_LEFT)
    return ParagraphStyle(name, **kw)

S = {
    "name": ps("name", fontName="Serif", fontSize=30, leading=32, textColor=INK),
    "role": ps("role", fontName="MonoM", fontSize=8.6, leading=12, textColor=AMBER, spaceBefore=5),
    "meta": ps("meta", fontName="Mono", fontSize=7.7, leading=11.5, textColor=MUTE, spaceBefore=5),
    "sec":  ps("sec",  fontName="MonoM", fontSize=7.6, leading=10, textColor=AMBER),
    "sum":  ps("sum",  fontName="Sans", fontSize=8.9, leading=13.2, textColor=BODY),
    "title": ps("title", fontName="Serif", fontSize=15, leading=17, textColor=INK),
    "org":  ps("org",  fontName="MonoM", fontSize=8.2, leading=11, textColor=INK),
    "date": ps("date", fontName="Mono", fontSize=7.6, leading=11, textColor=MUTE),
    "blurb": ps("blurb", fontName="Sans", fontSize=7.9, leading=11, textColor=MUTE),
    "bul":  ps("bul",  fontName="Sans", fontSize=8.7, leading=12.4, textColor=BODY),
    "grp":  ps("grp",  fontName="MonoM", fontSize=7.4, leading=10, textColor=RUST),
    "skl":  ps("skl",  fontName="Sans", fontSize=8.5, leading=12, textColor=BODY),
    "sklk": ps("sklk", fontName="MonoM", fontSize=7.4, leading=12, textColor=AMBER),
}
S["bulr"] = ps("bulr", fontName="Sans", fontSize=8.7, leading=12.4,
               textColor=BODY, alignment=TA_RIGHT)

def rule(color=LINE, w=0.6, before=3, after=6):
    return HRFlowable(width="100%", thickness=w, color=color,
                      spaceBefore=before, spaceAfter=after, lineCap="butt")

def section(label):
    return [Spacer(1, 9), Paragraph(label, S["sec"]), rule()]

def bullet(lead, text, sub=False):
    dot = "\u2022" if not sub else "\u00b7"
    dot_color = AMBER if not sub else MUTE
    body = (f'<b><font color="#1A1714">{lead}</font></b>{text}'
            if lead else text)
    mark_style = S["bulr"] if sub else S["bul"]
    t = Table(
        [[Paragraph(f'<font color="#{dot_color.hexval()[2:]}">{dot}</font>', mark_style),
          Paragraph(body, S["bul"])]],
        # Sub-bullets indent by widening the marker column and right-aligning
        # the marker, rather than padding a column narrower than its content.
        colWidths=[22 if sub else 10, None],
    )
    t.setStyle(TableStyle([
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("LEFTPADDING", (0, 0), (-1, -1), 0),
        ("RIGHTPADDING", (0, 0), (-1, -1), 0),
        ("TOPPADDING", (0, 0), (-1, -1), 0.6),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 1.6),
        ("RIGHTPADDING", (0, 0), (0, 0), 4 if sub else 0),
    ]))
    return t

def role_header(title, org, dates, blurb):
    head = Table([[Paragraph(org, S["org"]), Paragraph(dates, S["date"])]],
                 colWidths=[None, 105])
    head.setStyle(TableStyle([
        ("ALIGN", (1, 0), (1, 0), "RIGHT"),
        ("VALIGN", (0, 0), (-1, -1), "BOTTOM"),
        ("LEFTPADDING", (0, 0), (-1, -1), 0),
        ("RIGHTPADDING", (0, 0), (-1, -1), 0),
        ("TOPPADDING", (0, 0), (-1, -1), 1),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 0),
    ]))
    return [Paragraph(title, S["title"]), Spacer(1, 2), head,
            Spacer(1, 3), Paragraph(blurb, S["blurb"]), Spacer(1, 5)]

# ── content ──────────────────────────────────────────────────────────────────
F = []
F.append(Paragraph("Jeremiah Parrack", S["name"]))
F.append(Paragraph("LEAD SOFTWARE ENGINEER  ·  SITE RELIABILITY / PLATFORM", S["role"]))
F.append(Paragraph(
    "Atlanta, GA  ·  jeremiahlukus1@gmail.com  ·  github.com/jeremiahlukus  ·  "
    "jeremiahlukus.github.io  ·  linkedin.com/in/jeremiahlukus", S["meta"]))
F.append(rule(color=AMBER, w=1.1, before=7, after=2))

F += section("SUMMARY")
F.append(Paragraph(
    "Software engineer with nine years building and operating production systems on AWS. I work at the "
    "seam between application code and the platform it runs on &mdash; shipping Rails, TypeScript, and "
    "Flutter applications, then automating the infrastructure, pipelines, and patching that keep them "
    "alive. Currently leading reliability and platform work across 311 repositories and 26 GitHub "
    "organizations at Cox Automotive, contributing to the Ruby and Rust open source that runs Rails on AWS "
    "Lambda, and publishing Flutter packages and apps of my own.", S["sum"]))

F += section("EXPERIENCE")

F += role_header(
    "Lead Software Engineer / SRE", "Manheim &mdash; Cox Automotive", "May 2018 &ndash; Present",
    "World&rsquo;s largest wholesale auto auction: 145 auction sites across North America, Europe, Asia, and Australia.")
for lead, text in [
    ("Fleet-scale ownership: ", "4,000+ commits across 311 repositories in 26 GitHub organizations."),
    ("Automated dependency patching: ", "wrote Python tooling that scans a GitHub Enterprise org for outdated AWS service versions &mdash; Elastic Beanstalk solution stacks, AWS Glue versions, and Terraform releases &mdash; opens pull requests with the upgrade, flags severely outdated versions, and posts Slack notifications on a recurring schedule."),
    ("CI standardization: ", "migrated 100+ repositories onto shared, standardized GitHub Actions runners and upgraded reusable Terraform workflows org-wide, retiring per-team Jenkins pipelines."),
    ("Data platform: ", "built the Terraform and AWS Glue infrastructure behind DealShield&rsquo;s Assurance Protect Management System &mdash; ETL pipelines for fraud modeling, pending-reason analysis, problem-VIN detection, and inventory &mdash; plus Snowflake production and lower environments."),
    ("Seller Tools: ", "Terraform for Seller Dashboard and API gateway infrastructure, plus sale-history and disclosure services."),
    ("Developer experience: ", "authored reusable pipeline templates for serverless apps, Angular modules, and npm packages, cutting pipeline definitions from hundreds of lines to roughly twenty so teams could own their own deploys."),
    ("Observability: ", "implemented logging, custom metrics, and dashboards that cut hours off production debugging; standardized alerting and secrets management on AWS Parameter Store across teams."),
    ("Governance: ", "onboarded workloads to the internal service catalog and authored Production Readiness Review documentation."),
    ("Enablement: ", "ran recurring talks and tutorials on Terraform, deployment ownership, and the release process; mentored engineers out of the apprenticeship program."),
]:
    F.append(bullet(lead, text))

F.append(Spacer(1, 10))
F += role_header(
    "Founder / Lead Software Engineer", "Jeremiah Parrack LLC", "Feb 2021 &ndash; Present",
    "Independent consultancy: client engineering plus my own published apps.")
F.append(bullet("Acuity PPM: ", "full-stack and platform engineering on a project-portfolio-management SaaS &mdash; a Rails API with a React/TypeScript frontend running on AWS Lambda. 215+ commits."))
for t in [
    "Serverless deploy automation, dedicated per-client production environments, and ephemeral review environments.",
    "Lambda access to Postgres on RDS inside a VPC, Hasura, and SQS dead-letter queues with job retry.",
    "New Relic, Sentry, Lambda Insights, log retention, and frontend caching.",
    "Secure environment loading through Crypteia and Rails-on-Lambda through Lamby &mdash; both projects I contribute to upstream, so production experience feeds the libraries directly.",
]:
    F.append(bullet("", t, sub=True))
F.append(bullet("Own products: ", "four applications shipped to the App Store and Google Play."))
for lead, t in [
    ("FlowJitsu &mdash; ", "jiu-jitsu training tracker with an offline-first local database that syncs to the cloud. Over 1,000 users. Flutter, Firebase; iOS and Android."),
    ("Joyful Noise Tabs &mdash; ", "guitar tab and chord library for worship musicians, 6,000+ songs and over 600 users. Flutter, Firebase; iOS."),
    ("Pneuma Stream &mdash; ", "AI-narrated reading library that underlines each sentence as it is spoken. Flutter; iOS."),
    ("Smart Sprout &mdash; ", "AI-powered learning companion that adapts material to the learner. Flutter; iOS."),
]:
    F.append(bullet(lead, t, sub=True))
F.append(bullet("Delivery: ", "led a small delivery team, translated client requirements into scoped work, and built in-app subscriptions, release automation, and reusable logging and monitoring packages."))

F.append(Spacer(1, 10))
F += role_header(
    "Software Engineer", "Stord", "Sept 2017 &ndash; May 2018",
    "Seed-stage logistics startup where I was the only developer. Stord has since raised $777M and reached a $3B valuation.")
for lead, t in [
    ("Built the first production platform: ", "the Ruby application and data model behind multi-warehouse inventory and product flow, letting brands see and move stock across every warehouse from one dashboard &mdash; including a ground-up redesign of the database it all sat on."),
    ("Owned the integration layer: ", "connected third-party warehouse management systems over SOAP and REST so inventory synced automatically between Stord and partner warehouses, which is what made a network of independent operators work as one."),
    ("Laid the engineering foundations: ", "introduced continuous integration, automated error alerting, and Elasticsearch, and set the unit and functional testing, debugging, security, and documentation practices the team scaled on."),
]:
    F.append(bullet(lead, t))

F += section("OPEN SOURCE")
F.append(Paragraph("RUBY &amp; RUST &mdash; RUNNING RAILS ON AWS LAMBDA", S["grp"]))
F.append(Spacer(1, 4))
for lead, t in [
    ("Lamby &mdash; 625 stars: ", "Rails on AWS Lambda. Added Rack 3 support, carried the gem from Rails 7.1 to 8.1 and onto Ruby 3.4 / Bundler 4, and made shutdown exit gracefully on SIGTERM."),
    ("Crypteia &mdash; 77 stars: ", "Rust Lambda extension that preloads secure environment variables. Remediated GHSA-82j2-j2ch-gfr8 (a denial-of-service in rustls-webpki), upgraded the Rust toolchain, and fixed multi-architecture ARM releases."),
    ("Lambdakiq &mdash; 198 stars: ", "ActiveJob on SQS and Lambda. Modernized CI, added a release workflow, and moved the gem to Ruby 3.4."),
    ("jetpacker: ", "added a Tailwind install task, upgraded RuboCop and fixed the resulting offenses, and repaired the test suite in the Ruby on Jets asset pipeline."),
]:
    F.append(bullet(lead, t))
F.append(Spacer(1, 6))
F.append(Paragraph("FLUTTER &amp; DART", S["grp"]))
F.append(Spacer(1, 4))
for lead, t in [
    ("authorize_net_plugin &mdash; pub.dev: ", "Flutter plugin I wrote and maintain, wrapping the native Android and iOS Authorize.Net payment SDKs behind one Dart API. Ten releases, still shipping."),
    ("flutter_template &mdash; 27 stars: ", "production Flutter starter &mdash; Riverpod state management, authentication flow, structured logging, and a test harness."),
    ("chewie &mdash; 2.1k stars: ", "removed a spurious iOS simulator warning from the community video player used across the Flutter ecosystem."),
    ("flutter_chord: ", "added chorus-style passthrough to the line processor and support for comment directives in this chord parser and renderer."),
]:
    F.append(bullet(lead, t))

F += section("TECHNICAL SKILLS")
rows = [
    ("LANGUAGES", "Ruby, Dart, TypeScript, JavaScript, Python, Rust, SQL, Bash"),
    ("FRAMEWORKS", "Rails, Flutter, React, Ruby on Jets, Hasura, Riverpod"),
    ("AWS", "Lambda, Glue, RDS, ECS, Elastic Beanstalk, SQS, SSM Parameter Store, VPC, CloudWatch, S3, IAM"),
    ("INFRASTRUCTURE", "Terraform, AWS CDK, AWS SAM, Docker, Snowflake, Firebase"),
    ("CI/CD &amp; OPS", "GitHub Actions, Jenkins, New Relic, Sentry, Lambda Insights, PostgreSQL, Redis, Elasticsearch"),
]
tbl = Table([[Paragraph(k, S["sklk"]), Paragraph(v, S["skl"])] for k, v in rows],
            colWidths=[92, None])
tbl.setStyle(TableStyle([
    ("VALIGN", (0, 0), (-1, -1), "TOP"),
    ("LEFTPADDING", (0, 0), (-1, -1), 0),
    ("RIGHTPADDING", (0, 0), (-1, -1), 0),
    ("TOPPADDING", (0, 0), (-1, -1), 1.5),
    ("BOTTOMPADDING", (0, 0), (-1, -1), 3),
]))
F.append(tbl)

F += section("EDUCATION")
ed = Table([[Paragraph("Georgia State University", S["org"]),
             Paragraph("May 2018", S["date"])]], colWidths=[None, 105])
ed.setStyle(TableStyle([
    ("ALIGN", (1, 0), (1, 0), "RIGHT"),
    ("LEFTPADDING", (0, 0), (-1, -1), 0),
    ("RIGHTPADDING", (0, 0), (-1, -1), 0),
    ("TOPPADDING", (0, 0), (-1, -1), 0),
    ("BOTTOMPADDING", (0, 0), (-1, -1), 1),
]))
F.append(ed)
F.append(Paragraph("B.S. Computer Science, concentration in Computer Software Systems", S["skl"]))

# ── build ────────────────────────────────────────────────────────────────────
def footer(canvas, doc):
    canvas.saveState()
    canvas.setFont("Mono", 7)
    canvas.setFillColor(MUTE)
    canvas.drawString(0.62 * inch, 0.38 * inch, "Jeremiah Parrack")
    canvas.drawRightString(LETTER[0] - 0.62 * inch, 0.38 * inch, f"Page {doc.page}")
    canvas.restoreState()

doc = BaseDocTemplate(
    OUT, pagesize=LETTER,
    leftMargin=0.62 * inch, rightMargin=0.62 * inch,
    topMargin=0.5 * inch, bottomMargin=0.58 * inch,
    title="Jeremiah Parrack — Resume",
    author="Jeremiah Parrack",
    subject="Lead Software Engineer / SRE",
)
frame = Frame(doc.leftMargin, doc.bottomMargin, doc.width, doc.height, id="body",
              leftPadding=0, rightPadding=0, topPadding=0, bottomPadding=0)
doc.addPageTemplates([PageTemplate(id="main", frames=[frame], onPage=footer)])
doc.build(F)
print("wrote", OUT)
