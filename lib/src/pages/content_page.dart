import 'package:material_ui/material_ui.dart';
import 'package:kpk/src/components/app_bar.dart';

class ContentPage extends StatefulWidget {
  final String urlSlug;
  const ContentPage({super.key, required this.urlSlug});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpkAppBar(),
      body: Center(child: Text('Welcome to ${widget.urlSlug}')),
    );
  }
}
