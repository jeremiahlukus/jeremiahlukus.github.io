import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    'Privacy Policy',
                    '''Last updated: January 1, 2026

The privacy of your data—and it is your data, not ours!—is a big deal to us. In this policy, we lay out: what data we collect and why; how your data is handled; and your rights with respect to your data. We promise we never sell your data: never have, never will.

This policy applies to all products, services, and applications built and maintained by Jeremiah Parrack.''',
                  ),
                  _buildSection(
                    context,
                    'What We Collect and Why',
                    '''Our guiding principle is to collect only what we need. Here's what that means in practice:''',
                  ),
                  _buildSubSection(
                    context,
                    'Identity and Access',
                    '''When you sign up for our products or services, we may ask for identifying information such as your name, email address, and maybe a company name. That's so you can personalize your account, and we can send you product updates and other essential information. We may also send you optional surveys from time to time to help us understand how you use our products and to make improvements.

We'll never sell your personal information to third parties, and we won't use your name or company in marketing statements without your permission either.''',
                  ),
                  _buildSubSection(
                    context,
                    'Billing Information',
                    '''If you sign up for a paid product or service, you may be asked to provide your payment information and billing address. Credit card information is submitted directly to our payment processor and doesn't hit our servers. We store a record of the payment transaction, including the last 4 digits of the credit card number, for purposes of account history, invoicing, and billing support.''',
                  ),
                  _buildSubSection(
                    context,
                    'Website Interactions',
                    '''We collect information about your browsing activity for analytics and statistical purposes such as conversion rate testing and experimenting with new product designs. This includes, for example, your browser and operating system versions, your IP address, which web pages you visited and how long they took to load, and which website referred you to us.''',
                  ),
                  _buildSubSection(
                    context,
                    'Cookies',
                    '''We use persistent first-party cookies and some third-party cookies to store certain preferences, make it easier for you to use our applications, and perform A/B testing as well as support some analytics.

A cookie is a piece of text stored by your browser. It may help remember login information and site preferences. You can adjust cookie retention settings and accept or block individual cookies in your browser settings, although our apps won't work and other aspects of our service may not function properly if you turn cookies off.''',
                  ),
                  _buildSubSection(
                    context,
                    'Voluntary Correspondence',
                    '''When you email us with a question or to ask for help, we keep that correspondence, including your email address, so that we have a history of past correspondence to reference if you reach out in the future.

We also store information you may volunteer, for example, written responses to surveys.''',
                  ),
                  _buildSubSection(
                    context,
                    'Mobile App Permissions',
                    '''We offer optional mobile apps for some of our products. Because of how the platforms are designed, our apps typically must request your consent before accessing contacts, calendar, camera, and other privacy-sensitive features of your device. Consent is always optional and our apps will function without it, though some features may be unavailable.''',
                  ),
                  _buildSection(
                    context,
                    'When We Access or Disclose Your Information',
                    '''**To provide products or services you've requested.** We may use third-party subprocessors to help run our applications and provide the Services to you.

**To help you troubleshoot or squash a software bug, with your permission.** If at any point we need to access your content to help you with a support case, we will ask for your consent before proceeding.

**Aggregated and de-identified data.** We may aggregate and/or de-identify information collected through the services. We may use de-identified or aggregated data for any purpose, including marketing or analytics.

**When required under applicable law.** We are required to comply with valid legal processes such as warrants, court orders, or subpoenas that require us to disclose data.''',
                  ),
                  _buildSection(
                    context,
                    'Your Rights With Respect to Your Information',
                    '''We strive to apply the same data rights to all customers, regardless of their location. Some of these rights include:

• **Right to Know.** You have the right to know what personal information is collected, used, shared or sold.

• **Right of Access.** This includes your right to access the personal information we gather about you, and your right to obtain information about the sharing, storage, security and processing of that information.

• **Right to Correction.** You have the right to request correction of your personal information.

• **Right to Erasure / "To Be Forgotten".** This is your right to request, subject to certain limitations under applicable law, that your personal information be erased from our possession and, by extension, from all of our service providers.

• **Right to Complain.** You have the right to make a complaint regarding our handling of your personal information with the appropriate supervisory authority.

• **Right to Restrict Processing.** This is your right to request restriction of how and why your personal information is used or processed, including opting out of sale of your personal information. (Again: we never have and never will sell your personal data.)

• **Right to Object.** You have the right, in certain situations, to object to how or why your personal information is processed.

• **Right to Portability.** You have the right to receive the personal information we have about you and the right to transmit it to another party.

• **Right to Non-Discrimination.** We do not and will not charge you a different amount to use our products, offer you different discounts, or give you a lower level of customer service because you have exercised your data privacy rights.''',
                  ),
                  _buildSection(
                    context,
                    'How We Secure Your Data',
                    '''All data is encrypted via SSL/TLS when transmitted from our servers to your browser. The database backups are also encrypted. In addition, we go to great lengths to secure your data at rest.''',
                  ),
                  _buildSection(
                    context,
                    'Data Retention',
                    '''We keep your information for the time necessary for the purposes for which it is processed. The length of time for which we retain information depends on the purposes for which we collected and use it and your choices, after which time we may delete and/or aggregate it. We may also retain and use this information as necessary to comply with our legal obligations, resolve disputes, and enforce our agreements.''',
                  ),
                  _buildSection(
                    context,
                    'Location of Site and Data',
                    '''Our products and other web properties are operated in the United States. If you are located in the European Union, UK, or elsewhere outside of the United States, please be aware that any information you provide to us will be transferred to and stored in the United States. By using our websites or Services and/or providing us with your personal information, you consent to this transfer.''',
                  ),
                  _buildSection(
                    context,
                    'Changes and Questions',
                    '''We may update this policy as needed to comply with relevant regulations and reflect any new practices. Whenever we make a significant change to our policies, we will refresh the date at the top of this page and take any other appropriate steps to notify users.

Have any questions, comments, or concerns about this privacy policy, your data, or your rights with respect to your information? Please get in touch by emailing us and we'll be happy to try to answer them!''',
                  ),
                  const SizedBox(height: 32),
                  _buildContactButton(context),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 48,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your data privacy is important to us',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _buildRichText(context, content),
        ],
      ),
    );
  }

  Widget _buildSubSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          _buildRichText(context, content),
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String content) {
    // Simple markdown-like bold text parsing
    final List<TextSpan> spans = [];
    final RegExp boldPattern = RegExp(r'\*\*(.+?)\*\*');
    int lastEnd = 0;

    for (final match in boldPattern.allMatches(content)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: content.substring(lastEnd, match.start),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.6,
              ),
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.6,
            ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < content.length) {
      spans.add(TextSpan(
        text: content.substring(lastEnd),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              height: 1.6,
            ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _launchEmail(),
        icon: const Icon(Icons.email, color: Colors.white),
        label: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'jeremiahlukus1@gmail.com',
      queryParameters: {'subject': 'Privacy Policy Inquiry'},
    );
    await launchUrl(emailLaunchUri);
  }
}
