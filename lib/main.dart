import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;

void main() => runApp(MaterialApp(home: ListAppsPages()));

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
      appBar: AppBar(
        title: Text("Installed applications"),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                    value: 'system_apps', child: Text('Toggle system apps')),
                PopupMenuItem<String>(
                  value: "launchable_apps",
                  child: Text('Toggle launchable apps only'),
                )
              ];
            },
            onSelected: (key) {
              if (key == "system_apps") {
                setState(() {
                  _showSystemApps = !_showSystemApps;
                });
              }
              if (key == "launchable_apps") {
                setState(() {
                  _onlyLaunchableApps = !_onlyLaunchableApps;
                });
              }
            },
          )
        ],
      ),
      body: _ListAppsPagesContent(
          includeSystemApps: _showSystemApps,
          onlyAppsWithLaunchIntent: _onlyLaunchableApps,
          key: GlobalKey()),
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
            return const Center(child: CircularProgressIndicator());
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
                              horizontal: 20.0, vertical: 20.0),
                          leading: Container(
                              child: app is ApplicationWithIcon
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(app.icon),
                                      backgroundColor: Colors.white,
                                    )
                                  : null),
                          title: Text("${app.appName}"),
                          subtitle: Text('Version: ${app.versionName}\n'
                              'Package: ${app.packageName}'),
                          onLongPress: () => {
                            uninstallApp(app.packageName)
                                .then(setState(() => null))
                          },
                          trailing: InkWell(
                            child: Container(
                              child: Icon(Icons.delete_forever,
                                  color: Colors.black, size: 30.0),
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

  setState(Null Function() param0) {}
}
