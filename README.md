# Git Server

## Setup

To keep `soft-serve` version up to date
add the following lines to `sudo crontab`.

```
# update repos
* */4 * * * make -C /home/daylin/git soft-repos
# update container so home page is semi-accurate
0 2 * * * make -C /home/daylin/git update-soft-serve
```

Notable changes to `app.ini`

```dosini
APP_NAME = Daylin's Git Server
RUN_MODE = prod
RUN_USER = git

[server]
DOMAIN     = https://git.dayl.in
SSH_DOMAIN = git.dayl.in
ROOT_URL   = https://git.dayl.in/

[service]
DISABLE_REGISTRATION = true
NO_REPLY_ADDRESS     = noreply.git.dayl.in

[ui]
DEFAULT_THEME = arc-green
THEMES        = arc-green

[openid]
ENABLE_OPENID_SIGNIN = false
ENABLE_OPENID_SIGNUP = false
```

## Where is this repo?

github < mirror > gitea < mirror > soft-serve

This repo is hosted on github but mirrored to my self-hosted [`gitea`](https://gitea.io/en-us/) instance.
Once there it will be mirrored to an instance of [`soft-serve`](https://github.com/charmbracelet/soft-serve).

Check it out with `ssh -p 23231 git.dayl.in`.
