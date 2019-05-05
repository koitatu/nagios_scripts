# nagios_scripts  
nagios用スクリプト。  
  

### check_cert.sh
SSL証明書の有効期限監視スクリプト。  
check_httpプラグインでは監視できない、iOSプッシュ通知用SSL証明書向け。けど、他にも使えると思う。  
  

### slack.sh
Nagiosからslackへ通知を飛ばすための連携スクリプト。
下記URLのものをパク…真似ました。。。

* オリジナル  
https://gist.github.com/bakorer/199dd38779440d2f7980  
  
* 参考にさせていただいた記事  
http://codenote.net/slack/2768.html  
  