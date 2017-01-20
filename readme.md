# 使い方

### 設置方法

```
$ git@github.com:iganari/rancher-dev.git
$ cd rancher-dev/opsfiles/vagrant
$ vagrant up
```

これで2台のUbuntuが立ち上がる。

IP | hostname | VirtualBox name | vagrant name
:-:|:-:|:-:|:-:
192.168.133.111 | rancher-dev01 | rancher-dev01 | svr01
192.168.133.112 | rancher-dev02 | rancher-dev02 | svr02
192.168.133.113 | rancher-dev03 | rancher-dev03 | svr03

### rancher hostので作業

上記で立ち上げたサーバーのうち、1台をrancherのmasterにし、エンドポイントにする。

+ rancher-dev01にvagrant sshログイン

```
$ cd opsfiles/vagrant
$ vagrant ssh svr01

=====================
ここからは、vagrant内

$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

上記が正常に動いたらブラウザから下記にアクセス

http://192.168.33.111:8080

### rancherのhostを設定しなくてはイケない

rancherのhostをきめる

host --> add 

まずは自分を設定する
これで1つのサーバの中に
rancherのwebとrancherのコンテナをおくhostサーバが立ち上がるミニマムな環境が出来る

```
$ cd opsfiles/vagrant
$ vagrant ssh svr01

=====================
ここからは、vagrant内

$ sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.1.3 http://192.168.33.111:8080/v1/scripts/9D8492950C217E7ADFF6:1484845200000:64KOq6LggxSIDVBQAG0YhrQGdQU
```

上記はwebに書いてあるものをコピーにして貼るのみ
しばらくすると、hostに登録されます

### 2台目を作る

rancher-dev02をhostに登録する

host > add
で、192.168.33.112用のコマンド発行

これをrancher-dev02でうつ(rancher-dev01ではない)

```
$ cd opsfile/vagrant
$ vagrant ssh svr02

=====================
ここからは、vagrant内

sudo docker run -e CATTLE_AGENT_IP="192.168.33.112"  -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.1.3 http://192.168.33.111:8080/v1/scripts/9D8492950C217E7ADFF6:1484845200000:64KOq6LggxSIDVBQAG0YhrQGdQU

```

以上で、たされたので再びhostで確認

2台目も確認できたらOK

### wordpess

カタログから立ち上げ

IPの確認

192.168.33.112
でおｋ

### まとめ

構築テストは仮想でもいいけど、それいじょうやるとmacが悲鳴をあげます
