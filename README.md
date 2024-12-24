# Git Server

This configuration utilizes `docker`, `gitea`, `caddy`, and `soft serve` for my own self-hosted git instance.

Attracted by the feature set of [`gitea`](https://gitea.io)
and the charm (pun intended) of [`soft serve`](https://github.com/charmbracelet/soft-serve),
I was unable to choose how to host my own git instance, so I didn't.

Combining the best of both worlds,
I manually update repos served by `soft serve` with a simple cron job
to afford myself both a TUI and a browser.

## Setup

Notable changes to `app.ini` for `gitea`.

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

[service.explore]
DISABLE_USERS_PAGE = true

[ui]
DEFAULT_THEME = arc-green
THEMES        = arc-green

[openid]
ENABLE_OPENID_SIGNIN = false
ENABLE_OPENID_SIGNUP = false
```

All repos on the `soft-serve` instance are handled using it's mirror feature.
A list of repos are maintained at `soft/repos.txt` and checked/added by running `soft/add-mirrors`.

## Where is this repo, actually?

github < mirror > gitea < mirror > soft-serve

This repo is hosted on github but mirrored to my self-hosted [`gitea`](https://gitea.io/en-us/) instance.
Once there it will be "mirrored" to an instance of [`soft-serve`](https://github.com/charmbracelet/soft-serve).


### [github](https://github.com/daylinmorgan/git-server)

### [git.dayl.in](https://git.dayl.in/daylin/git-server)

### soft-serve 

```bash
ssh -p 23231 git.dayl.in
```
