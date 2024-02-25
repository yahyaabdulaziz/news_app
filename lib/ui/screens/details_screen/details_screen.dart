import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/ui/screens/article_webview/article_webview.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailsScreen extends StatefulWidget {
  static const String routeName = "DetailsScreen";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        title: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              arg.title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: arg.urlToImage ?? "",
                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  arg.source?.name ?? "",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff79828B)),
                ),
              ),
              Text(
                arg.title ?? "",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff42505C)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  timeago.format(DateTime.parse(arg.publishedAt ?? ""),
                      allowFromNow: true),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA3A3A3)),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  arg.content ?? "",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff42505C)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ArticleWebView.routeName,
                      arguments: arg.url ?? "");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View Full article",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff42505C)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xff42505C),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
