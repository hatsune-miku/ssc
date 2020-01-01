# SSC by EGGTART😈

* ensure ruby version >= 2.5
```bash
$ apt uninstall ruby
$ gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```
  * without proxy:
  ```bash
  $ curl -L https://get.rvm.io | bash -s stable
  ```
  * with proxy:
  ```bash
  $ curl -x <proxy_addr> -L https://get.rvm.io | bash -s stable
  $ rvm install 2.5
  ```

* ensure gem is latest version
```bash
$ apt remove gem
$ apt install gem
```

* ensure ralis is latest version
```bash
$ gem uninstall rails
$ gem install rails
```
