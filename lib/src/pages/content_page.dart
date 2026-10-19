import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/components/app_bar.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/date_helper.dart';
import 'package:kpk/src/models/page.dart';
import 'package:kpk/src/providers/pages_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentPage extends StatefulWidget {
  final String urlSlug;
  const ContentPage({super.key, required this.urlSlug});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<PageContent> pages = [];
  String error = '';
  int _fetchGeneration = 0;

  Future<void> fetchContent() async {
    final fetchGeneration = ++_fetchGeneration;
    final urlSlug = widget.urlSlug;
    final map = {'page_id': '', 'page_url_slug': urlSlug};
    final res = await PagesProvider.getContent(map);
    debugPrint(res.pages.length.toString());
    if (!mounted || fetchGeneration != _fetchGeneration) return;

    setState(() {
      pages = res.pages;
      error = res.error;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  @override
  void didUpdateWidget(covariant ContentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.urlSlug != widget.urlSlug) {
      fetchContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpkAppBar(),
      body: error.isNotEmpty
          ? Center(child: Text(error))
          : (pages.isEmpty
                ? Center(child: Text('Unable to find the page!'))
                : SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: kMaxWidth),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          mainAxisSize: .min,
                          spacing: 16.0,
                          children: [
                            HListItemData(
                              title: Text(
                                pages[0].title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: .bold,
                                ),
                              ),
                              subtitle: Text(
                                formatDateStringDDMMMYYYY(pages[0].modified),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                final imageUrl =
                                    '$kImageUrl/${pages[0].featureImage}';
                                showHDialog(
                                  context,
                                  builder: (dialogContext) {
                                    final size = MediaQuery.sizeOf(
                                      dialogContext,
                                    );
                                    return HDialog(
                                      maxWidth: size.width - 32,
                                      maxHeightFactor: 0.9,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: size.width - 72,
                                          maxHeight: size.height * 0.8,
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: HCard(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '$kImageUrl/${pages[0].featureImage}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            HtmlWidget(
                              pages[0].content,
                              onTapUrl: (url) async {
                                return await launchUrl(Uri.parse(url));
                              },
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  )),
    );
  }
}
