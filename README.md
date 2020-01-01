# SSC by EGGTART😈
# how to run this program without error:

* ensure **ruby** version >= 2.5
```bash
$ apt uninstall ruby
$ gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ curl -L https://get.rvm.io | bash -s stable
```

* ensure **gem** is in latest version
```bash
$ apt remove gem
$ apt install gem
```

* for **chinese developer** under GFW
```bash
$ gem sources -r https://rubygems.org/
$ gem sources -a https://gems.ruby-china.com/
```

* ensure **rails** is in latest version
```bash
$ gem uninstall rails
$ gem install rails
```

* ensure **bundler** version >= 2.1.2
```bash
$ gem uninstall bundler
$ gem install bundler
```

* ensure build environment for **nokogiri, mysql2, etc**
```bash
$ apt install build-essential
$ apt install libmysqld-dev
```
