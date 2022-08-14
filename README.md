# Server Config


Important Changes to `app.ini`

```dosini
APP_NAME = Daylin's Git Server
RUN_MODE = prod
RUN_USER = git

[server]
DOMAIN           = https://git.dayl.in
SSH_DOMAIN       = git.dayl.in
ROOT_URL         = https://git.dayl.in/

[service]
DISABLE_REGISTRATION              = true
NO_REPLY_ADDRESS                  = noreply.git.dayl.in

[ui]
DEFAULT_THEME = arc-green
THEMES        = auto,gitea,arc-green

[openid]
ENABLE_OPENID_SIGNIN = false
ENABLE_OPENID_SIGNUP = false
```
