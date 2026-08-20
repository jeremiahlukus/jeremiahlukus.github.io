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
                    '''Last updated: August 20, 2026

This Privacy Policy is published by **Jeremiah Parrack**, an individual sole proprietor (the "Developer", "we", "us", or "our"), and it covers the mobile application **FlowJitsu** (Google Play package name: **com.jparrack.flowjitsu**), distributed on the Google Play Store by the developer **Jeremiah Parrack**.

The privacy of your data—and it is your data, not ours!—is a big deal to us. In this policy, we lay out: what data we collect and why; how your data is handled; and your rights with respect to your data. We promise we never sell your data: never have, never will.

This policy applies to **FlowJitsu** and to all other products, services, and applications built and maintained by **Jeremiah Parrack**.''',
                  ),
                  _buildSection(
                    context,
                    'App and Developer Identification',
                    '''• **App name:** FlowJitsu

• **Google Play package name (application ID):** com.jparrack.flowjitsu

• **Developer / legal entity:** Jeremiah Parrack (individual sole proprietor)

• **Google Play developer account name:** Jeremiah Parrack

• **Contact email:** jeremiahlukus1@gmail.com

• **Country of operation:** United States

This is the official privacy policy for the FlowJitsu app and it is the policy linked from the FlowJitsu Google Play store listing and from the app's Google Play Data safety section.''',
                  ),
                  _buildSection(
                    context,
                    'What We Collect and Why',
                    '''Our guiding principle is to collect only what we need. Here's what that means in practice:''',
                  ),
                  _buildSubSection(
                    context,
                    'Identity and Access',
                    '''FlowJitsu uses Google Firebase Authentication to sign you in. You can create an account with an email address and password, or sign in with Google. When you do, we receive and store your email address, a unique account identifier, and — if you sign in with Google — the display name and profile photo associated with that Google account. We use this to sign you in, keep your training data attached to your account, and sync it across your devices.

We'll never sell your personal information to third parties, and we won't use your name in marketing statements without your permission.''',
                  ),
                  _buildSubSection(
                    context,
                    'Payment and Financial Information',
                    '''FlowJitsu does not accept payments. We do not sell subscriptions or in-app purchases through the app, and we never collect, process, or store payment card numbers, bank account details, billing addresses, or any other financial information.''',
                  ),
                  _buildSubSection(
                    context,
                    'Training Content You Create',
                    '''FlowJitsu exists to log your jiu-jitsu training, so most of the data in the app is content you enter yourself: session logs and dates, techniques, notes, practice plans, instructional libraries, belt and stripe progress, and any photos or videos you choose to attach to a session.

This content is stored locally on your device and, when you are signed in, synced to your account in Google Cloud Firestore. Photos and videos you attach are uploaded to Google Firebase Storage. Your training content is private to your account — we do not publish it, share it with other users, or sell it.''',
                  ),
                  _buildSubSection(
                    context,
                    'AI-Assisted Features',
                    '''FlowJitsu includes optional AI features, such as identifying a technique from a description you type and looking up the curriculum or contents of a published instructional.

When you use one of these features, the text of that specific request — for example, the technique description or instructional title you entered — is sent to third-party AI providers to generate a response. We currently use **OpenAI** (api.openai.com) and **Perplexity** (api.perplexity.ai) for this purpose. We send only the text needed to answer the request. We do not send your account email, your full training history, or your photos and videos to these providers. If you do not use the AI features, no data is sent to them.

Your use of these features is subject to the privacy policies of those providers in addition to this one.''',
                  ),
                  _buildSubSection(
                    context,
                    'App Usage and Device Information',
                    '''We use Google Firebase Analytics to understand how the app is used so we can fix problems and decide what to improve. This collects information such as your device model and operating system version, app version, language and general region, crash and error diagnostics, in-app events (for example, which screens are opened), and a mobile advertising identifier.

We use this only for analytics and stability. We do not serve third-party advertising in FlowJitsu and we do not use this data to build advertising profiles or sell it to data brokers. You can reset or limit the advertising identifier in your device settings (on Android: Settings › Privacy › Ads).''',
                  ),
                  _buildSubSection(
                    context,
                    'Local Storage and Cookies',
                    '''On your device, FlowJitsu stores your training database and your preferences locally so the app works offline and remembers your settings. Clearing the app's storage or uninstalling the app removes this local copy.

On our website, we use first-party storage and cookies to remember basic preferences. A cookie is a small piece of text stored by your browser. You can accept or block cookies in your browser settings, though some parts of the site may not work correctly if you block them.''',
                  ),
                  _buildSubSection(
                    context,
                    'Voluntary Correspondence',
                    '''When you email us with a question or to ask for help, we keep that correspondence, including your email address, so that we have a history of past correspondence to reference if you reach out in the future.''',
                  ),
                  _buildSubSection(
                    context,
                    'Device Permissions We Request',
                    '''FlowJitsu asks for your consent before using privacy-sensitive features of your device. Every one of these is optional — the app works without them, though the related feature will be unavailable. We request only:

• **Camera** — to take photos and videos of your training sessions from inside the app.

• **Microphone** — to record audio as part of a training video.

• **Photos and media** — to attach existing photos or videos from your library to a session.

• **Notifications** — to send you reminders you have set up in the app.

Photos, videos, and audio captured through these permissions are used only for the training entries you attach them to. FlowJitsu does not request access to your contacts, your calendar, your location, your call logs, your SMS messages, or your microphone outside of video recording.''',
                  ),
                  _buildSection(
                    context,
                    'When We Access or Disclose Your Information',
                    '''**To provide products or services you've requested.** We use the following third-party subprocessors to run FlowJitsu:

• **Google (Firebase)** — Firebase Authentication for sign-in, Cloud Firestore for your training data, Firebase Storage for photos and videos, and Firebase Analytics for usage and stability reporting.

• **OpenAI** — processes the text of AI-assisted requests you initiate, as described above.

• **Perplexity** — processes instructional lookup requests you initiate, as described above.

We do not share your information with any other third parties for their own purposes.

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
                    '''All data is encrypted in transit via SSL/TLS between your device and our service providers, and is encrypted at rest by Google Cloud Platform, which hosts our Firebase services. Access to your training content is restricted to your authenticated account through Firebase security rules.''',
                  ),
                  _buildSection(
                    context,
                    'Deleting Your Account and Your Data',
                    '''You can delete your FlowJitsu account and its associated data at any time, in either of two ways:

• **In the app.** Open your profile screen and choose **Delete Account**. This erases the training data stored on your device and permanently deletes your sign-in account, after which you can no longer access it.

• **By email.** Write to us at **jeremiahlukus1@gmail.com** from the address associated with your account and ask us to delete your account and data. We will confirm and complete the request within 30 days.

A full deletion removes your account record, your training logs and notes, and the photos and videos you uploaded. Deletion from routine backups completes within 30 days, except where we are required to retain something to comply with a legal obligation. Data stored only locally on your device is also removed if you clear the app's storage or uninstall the app.''',
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

Have any questions, comments, or concerns about this privacy policy, your data, or your rights with respect to your information? Please get in touch and we'll be happy to try to answer them:

**Jeremiah Parrack** — developer of **FlowJitsu** (com.jparrack.flowjitsu)
Email: **jeremiahlukus1@gmail.com**''',
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
          'FlowJitsu (com.jparrack.flowjitsu) · Jeremiah Parrack',
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
