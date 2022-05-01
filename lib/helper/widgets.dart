import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/views/article_view.dart';
import 'package:news_app_api/views/news_page.dart';


class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile({this.imgUrl, this.desc, this.title, this.content, @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsPage(
              imgUrl: imgUrl,
              title: title,
              desc: desc,
              content: content,
              postUrl: posturl,
            )
        ));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 12,),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Text(
                      desc,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class NewsTileTopHeadLines extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTileTopHeadLines({this.imgUrl, this.desc, this.title, this.content, @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsPage(
              imgUrl: imgUrl,
              title: title,
              desc: desc,
              content: content,
              postUrl: posturl,
            )
        ));
      },
      child: Card(
        elevation: 4,
        child: Container(
            width: 180,
            height: 120,
            child: Container(
              child: Container(
//                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
                ),
                child: Stack(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          imgUrl,
                          height: 200,
                          width: 300,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black26
                      ),),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Container(
                        width: 300,
                        child: Text(
                          title,
//                      maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
