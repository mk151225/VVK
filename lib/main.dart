import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const VVKSalonApp());
}

class VVKSalonApp extends StatelessWidget {
  const VVKSalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VVK Salon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        useMaterial3: true,
      ),
      home: const SalonWebView(),
    );
  }
}

class SalonWebView extends StatefulWidget {
  const SalonWebView({super.key});

  @override
  State<SalonWebView> createState() => _SalonWebViewState();
}

class _SalonWebViewState extends State<SalonWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  // 🔗 Change this URL to your hosted page (GitHub Pages, etc.)
  // Or keep it as your Google Apps Script / any public URL.
  static const String _url =
      'https://mkmandrake.github.io/vvk-salon/'; // ← UPDATE THIS

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0D0D0D))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() {
            _isLoading = true;
            _hasError = false;
          }),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (_) => setState(() {
            _isLoading = false;
            _hasError = true;
          }),
        ),
      )
      ..loadRequest(Uri.parse(_url));
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'VVK SALON',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFD4AF37)),
            onPressed: _reload,
            tooltip: 'Refresh',
          ),
        ],
        bottom: _isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(3),
                child: LinearProgressIndicator(
                  backgroundColor: Color(0xFF1A1A1A),
                  color: Color(0xFFD4AF37),
                ),
              )
            : null,
      ),
      body: _hasError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, color: Color(0xFFD4AF37), size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load page',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Check your internet connection',
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : WebViewWidget(controller: _controller),
    );
  }
}
