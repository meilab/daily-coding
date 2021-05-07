import 'package:daily_coding/change_notifier/collect_notifier.dart';
import 'package:daily_coding/i18n/my_localizations.dart';
import 'package:daily_coding/utils/local_storage.dart';
import 'package:daily_coding/model/article_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() {
    return _CollectPageState();
  }
}

class _CollectPageState extends State<CollectPage> {
  List<ArticleItem> collectArticles = <ArticleItem>[];

  void _refresh() {
    List<String> strs = localStorageManager.getStringList('collects');
    List<ArticleItem> articles =
        Provider.of<CollectNotifier>(context, listen: false).articles;
    collectArticles.clear();
    strs.forEach((element) {
      int index = articles.indexWhere((d) => d.title == element);
      if (index != -1) {
        collectArticles.add(articles[index]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context)!.favorite()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 6.0,
                ),
                itemBuilder: (_, index) {
                  var articleItem = collectArticles[index];
                  return Material(
                    borderRadius: BorderRadius.circular(16.0),
                    elevation: 1.0,
                    shadowColor: Colors.white54,
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0)),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: Icon(articleItem.icon),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    articleItem.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 100, 100, 135),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.forward,
                                        color:
                                            Color.fromARGB(255, 100, 100, 135),
                                      ),
                                      Expanded(
                                        child: Text(
                                          articleItem.subtitle,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 100, 100, 135),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        articleItem.onTap();
                        setState(() {
                          _refresh();
                        });
                      },
                    ),
                  );
                },
                itemCount: collectArticles.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
