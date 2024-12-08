===output目录为IPTV-API更新源后手动上传===

1.文件名解释
tv+区号+运营商缩写cm/cu/ct为中国移动/联通/电信+Q/E为全部频道和鄂也就是央视加湖北频道缩写。

数据源
a.收录其它自维护数据源
https://a.lqtv.top/m3u/tv.m3u
https://ghp.ci/https://raw.githubusercontent.com/busyrock/IPTV/main/IPTV.m3u
https://ghp.ci/https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/iptv.m3u
https://ghp.ci/https://raw.githubusercontent.com/suxuang/myIPTV/main/ipv6.m3u
https://ghp.ci/https://raw.githubusercontent.com/YueChan/Live/blob/main/Global.m3u
https://ghp.ci/https://raw.githubusercontent.com/YueChan/Live/refs/heads/main/APTV.m3u
https://live.kilvn.com/iptv.m3u
b.Guovin自维护的数据源或已更新的output
https://ghp.ci/raw.githubusercontent.com/Guovin/iptv-api/gd/output/result.m3u

20241206数据
https://a.lqtv.top/m3u/tv.m3u,https://ghp.ci/https://raw.githubusercontent.com/busyrock/IPTV/main/IPTV.m3u,https://ghp.ci/https://raw.githubusercontent.com/Kimentanm/aptv/master/m3u/iptv.m3u,https://ghp.ci/https://raw.githubusercontent.com/suxuang/myIPTV/main/ipv6.m3u,https://ghp.ci/https://raw.githubusercontent.com/YueChan/Live/blob/main/Global.m3u,https://ghp.ci/https://raw.githubusercontent.com/YueChan/Live/refs/heads/main/APTV.m3u,https://live.kilvn.com/iptv.m3u,https://live.zbds.top/tv/iptv6.txt,https://live.zbds.top/tv/iptv4.txt,https://live.fanmingming.com/tv/m3u/ipv6.m3u,https://ghp.ci/https://raw.githubusercontent.com/joevess/IPTV/main/home.m3u8,https://aktv.top/live.txt,http://175.178.251.183:6689/live.txt,https://ghp.ci/https://raw.githubusercontent.com/kimwang1978/collect-tv-txt/main/merged_output.txt,https://m3u.ibert.me/txt/fmml_dv6.txt,https://m3u.ibert.me/txt/o_cn.txt,https://m3u.ibert.me/txt/j_iptv.txt,https://ghp.ci/https://raw.githubusercontent.com/xzw832/cmys/main/S_CCTV.txt,https://ghp.ci/https://raw.githubusercontent.com/xzw832/cmys/main/S_weishi.txt,http://itv.22m.top/ITVBox/tv/tvonline.txt,https://ghp.ci//https://raw.githubusercontent.com/asdjkl6/tv/tv/.m3u/整套直播源/测试/整套直播源/l.txt,https://ghp.ci//https://raw.githubusercontent.com/asdjkl6/tv/tv/.m3u/整套直播源/测试/整套直播源/kk.txt


2.方案
基于老人Win下使用，尽量少介入远端维护的思路，采用远程桌面+IPTV-API.exe手动本地更新测速源并更新到Github+极简TV各平台客户端自动更新的方案。好处是无需频繁寻找合适源，只需在大部分失效的情况下远程连接一次本地手动更新即可优选同步所有远程设备。
IPTV-API
https://github.com/Guovin/iptv-api/releases
极简TV
https://github.com/aiyakuaile/easy_tv_live/releases
https://gitee.com/AMuMuSir/easy_tv_live/releases


3.Tips
基于demo.txt为不同用户配置不同节目列表
基于config.ini配置不同输出文件名
urls_limit	10	单个频道接口数量
open_keep_all	False	保留所有检索结果，会保留非模板频道名称的结果，推荐手动维护时开启
ipv_type_prefer	自动	接口协议类型偏好，优先将该类型的接口排在结果前面，可选值：IPv4、IPv6、自动、auto
subscribe_urls		订阅源，请输入订阅链接（支持 txt 与 m3u 链接），多个链接以逗号分隔
origin_type_prefer	hotel,multicast,subscribe,online_search	结果偏好的接口来源，结果优先按该顺序进行排序，hotel：酒店源，multicast：组播源，subscribe：订阅源，online_search：关键字搜索
hotel_num	4	结果中偏好的酒店源接口数量
multicast_num	3	结果中偏好的组播源接口数量
subscribe_num	3	结果中偏好的订阅源接口数量
online_search_num	0	结果中偏好的关键字搜索接口数量
open_url_info	True	开启显示接口说明信息，用于控制是否显示分辨率、接口协议类型等信息，为$符号后的内容，播放软件使用该信息对接口进行描述
open_empty_category	False	开启无结果频道分类，自动归类至底部

4.流程
目前5个分支，深圳移动联通电信全/湖北移动全/湖北移动精简，IPTV-API目录复制三份，对demo.txt节目列表进行修改，按属地运营商跟节目列表进入更新。
config.ini中
urls_limit = 12
origin_type_prefer = subscribe,hotel,multicast,online_search
hotel_num = 3
multicast_num = 3
subscribe_num = 6
ipv_type_prefer = IPv6
ipv4_num = 5
ipv6_num = 7
非调试下面两个不要开Ture
open_keep_all = False
open_empty_category = False

20241206，demo.txt使用fanmingming的epg和图标，发现很多节目名不符导致无法正确归类，需要手动添加或者修改demo内的节目名。
例如
📺央视频道,#genre#
CCTV-1有cctv1/CCTV1等写法，只能手动添加
💰央视付费频道,#genre#
高尔夫网球有如下写法，需要手动添加
CCTV高尔夫球
CCTV高尔夫网球
CCTV央视高网
具体可以导入excel排序查看


