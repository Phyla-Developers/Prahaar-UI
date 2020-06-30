import 'package:PRAHAAR/pages/about.dart';
import 'package:PRAHAAR/pages/all_apps.dart';
import 'package:PRAHAAR/pages/disclaimer.dart';
import 'package:PRAHAAR/pages/social.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:animated_splash/animated_splash.dart';

void main() => runApp(MaterialApp(
      home: AnimatedSplash(
        imagePath: 'assets/images/emblem_1.jpg',
        home: ListAppsPages(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
      routes: {
        '/': (context) => ListAppsPages(),
        '/about': (context) => AboutScreen(),
        '/disclaimer': (context) => DisclaimerScreen(),
        '/all_apps': (context) => AllAppsScreen(),
        '/share': (context) => SocialScreen()
      },
    ));

class ListAppsPages extends StatefulWidget {
  @override
  _ListAppsPagesState createState() => _ListAppsPagesState();
}

class _ListAppsPagesState extends State<ListAppsPages> {
  bool _showSystemApps = false;
  bool _onlyLaunchableApps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text('Prahar'),
          backgroundColorStart: Colors.black,
          backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
          actions: <Widget>[
            InkWell(
              child: Container(
                child: Icon(Icons.replay, size: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              onTap: () => {
                setState(() {
                  _showSystemApps = !_showSystemApps;
                })
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 300,
                  child: Center(
                      child: Image.asset("assets/images/emblem_2.jpeg",
                          color: Color.fromRGBO(255, 255, 255, 1), scale: 0.1)),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(66, 66, 66, 1),
                            Colors.black
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                        )
                      ])),
              Expanded(
                  child: SizedBox(
                      height: 200.0,
                      child: _ListAppsPagesContent(
                          includeSystemApps: _showSystemApps,
                          onlyAppsWithLaunchIntent: _onlyLaunchableApps,
                          key: GlobalKey())))
            ],
          ),
        ),
        bottomNavigationBar: makeBottomNav(context));
  }

  makeBottomNav(BuildContext context) {
    return Container(
      height: 68.0,
      child: BottomAppBar(
        color: Color.fromRGBO(21, 21, 21, 0.95),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(children: <Widget>[
              IconButton(
                icon: Icon(Icons.info, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("About Us",
                      style: TextStyle(color: Colors.white, fontSize: 11)))
            ]),
            Column(children: <Widget>[
              IconButton(
                icon: Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/all_apps');
                },
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Banned Apps",
                      style: TextStyle(color: Colors.white, fontSize: 11)))
            ]),
            Column(children: <Widget>[
              IconButton(
                icon: Icon(Icons.priority_high, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/disclaimer');
                },
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Disclaimer",
                      style: TextStyle(color: Colors.white, fontSize: 11)))
            ]),
            Column(children: <Widget>[
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/share');
                },
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Share",
                      style: TextStyle(color: Colors.white, fontSize: 11)))
            ])
          ],
        ),
      ),
    );
  }
}

class _ListAppsPagesContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _ListAppsPagesContent(
      {Key key,
      this.includeSystemApps: false,
      this.onlyAppsWithLaunchIntent: false})
      : super(key: key);

  uninstallApp(appId) async {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_DELETE)
      ..setData(Uri.parse("package:$appId"))
      ..startActivityForResult().then((data) {
        print(data);
      });
  }

  @override
  Widget build(BuildContext context) {
    var bannedApps = [
      "com.zhiliaoapp.musically",
      "com.lenovo.anyshare.gps",
      "com.kwai.video",
      "com.UCMobile.intl",
      "com.baidu.BaiduMap",
      "com.zzkko",
      "com.hcg.cok.gp",
      "com.DUsavebattery.faster.charge",
      "com.DUsavebattery.faster.charge",
      "app.buzz.share",
      "video.like",
      "com.cyberlink.youcammakeup",
      "com.mi.global.bbs",
      "com.digitalnode.cmbrowser",
      "phone.antivirus.virus.cleaner.junk.clean.speed.booster.master",
      "com.apusapps.browser",
      "com.romwe",
      "club.fromfactory",
      "com.newsdog",
      "com.commsource.beautyplus",
      "com.tencent.mm",
      "com.uc.iflow",
      "com.tencent.androidqqmail",
      "com.weico.international",
      "cn.xender",
      "com.tencent.qqmusic",
      "com.tencent.mtt.intl",
      "sg.bigo.live",
      "com.meitu.wheecam",
      "com.netease.mail",
      "com.lbe.parallel.intl",
      "com.wMivideocallandchat_9258593",
      "com.jpro.wesync",
      "com.estrongs.android.pop",
      "com.quvideo.xiaoying",
      "com.mt.mtxx.mtxx",
      "com.ss.android.ugc.boom",
      "com.ai.bfly",
      "mobi.charmer.myscreenrecorder",
      "com.netqin.ps",
      "com.limsky.speedbooster",
      "com.DU.Cleaner.antivirus.cleanbooster",
      "com.duapps.cleaner",
      "com.baidu.browser.inter",
      "com.yy.hiyo",
      "com.intsig.camscanner",
      "com.cleanmaster.mguard",
      "com.baidu.baiducamera",
      "com.yubitu.android.YubiCollage",
      "com.playhdvideo.myvideoq",
      "com.videochat.livechat.wemeet",
      "com.cam001.selfie",
      "cm.aptoide.pt",
      "com.uc.vmate",
      "com.tencent.mobileqqi",
      "com.tencent.token",
      "com.tencent.qqlauncher",
      "com.kwai.global.video.social.kwaigo",
      "uk.co.aifactory.chessfree"
    ];
    return FutureBuilder(
        future: DeviceApps.getInstalledApplications(includeAppIcons: true),
        builder: (context, data) {
          if (data.data == null) {
            return const Center(
                child: Padding(
                    child: LinearProgressIndicator(),
                    padding: EdgeInsets.symmetric(horizontal: 40)));
          } else {
            List<Application> apps = data.data;
            List<Application> restrictApps = [];
            for (var i = 0; i < apps.length; i++) {
              if (bannedApps.contains(apps[i].packageName)) {
                restrictApps.add(apps[i]);
              }
            }
            apps = restrictApps;
            return ListView.builder(
                itemBuilder: (context, position) {
                  Application app = apps[position];
                  return Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 18.0),
                          leading: Container(
                              child: app is ApplicationWithIcon
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(app.icon),
                                      backgroundColor: Colors.white,
                                    )
                                  : null),
                          title: Text("${app.appName}"),
                          subtitle: Text('Version: ${app.versionName}\n'),
                          onLongPress: () => {uninstallApp(app.packageName)},
                          trailing: InkWell(
                            child: Container(
                              child: Icon(Icons.delete_outline,
                                  color: Colors.grey),
                            ),
                            onTap: () => {uninstallApp(app.packageName)},
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      )
                    ],
                  );
                },
                itemCount: apps.length);
          }
        });
  }
}
