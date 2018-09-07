This is the config file that BEST Aalborg used to sort emails from @BEST.eu.org.

The necessity for this comes from the fact that a good handful of besties don't use the right tags when sending emails. This is especially true for the mails send to the LBGs@BEST.eu.org mailing list, even through the rules about the different tags are written on the same pages.

## Setup - Linux
It is assumed that `imapfilter` and `python3` is install

1. Clone this repo to you computer
2. make a symbolic link to from `~/.imapfilter` to the clone repo
3. added your mails login information in the file `~/.imapfilter/accounts.lua`
4. Now create the systemd file `imapfilter.service` in `~/.config/systemd/user`
5. Enable the service my running the command `systemctl --user enable --now imapfilter.service`. You may have to run the command `systemctl --user daemon-reload`
6. If you want to auto updates of the filter, create the systemd file `imapfilter_update.service` in `~/.config/systemd/user`
7. Enable the service my running the command `systemctl --user enable --now imapfilter_update.service`. You may have to run the command `systemctl --user daemon-reload`


### Systemd
**`imapfilter.service`**
```
[Unit]
Description=Sort of mails from BEST

[Service]
WorkingDirectory=/home/%u/.imapfilter
ExecStart=/usr/bin/imapfilter
Restart=always
RestartSec=5min

[Install]
WantedBy=default.target
```

**`imapfilter_update.service`**
```
[Unit]
Description=Update config file to imapfilter from GitHub

[Service]
WorkingDirectory=/home/%u/.imapfilter
ExecStart=/usr/bin/git pull
Restart=always
RestartSec=60min

[Install]
WantedBy=default.target
```
