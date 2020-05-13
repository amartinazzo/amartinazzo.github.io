---
date: 2020-05-13
title: "Running Windows games on Linux with Steam Play"
---

There are [tons](https://itsfoss.com/steam-play) [of](https://www.pcgamer.com/how-to-play-windows-games-in-linux) [tutorials](https://segmentnext.com/2018/12/06/steam-proton-guide) going over how to try and run Windows games directly from Linux using Steam. After following a mix of advices from various places, I still could not run any Windows games. They would crash shortly after a "Preparing to launch" popup appeared.

In many cases, crashes are caused by stuff that has nothing to do with the games themselves. To figure out what is going on, it's a great idea to enable detailed logging. To do that, find the `user_settings.sample.py` file under the Proton folder. Mine was located at `$HOME/.local/share/Steam/steamapps/Proton 5.0`. Open it, set `"DXVK_LOG_LEVEL"` to `"debug"` and then rename the file to `user_settings.py`. After making these changes and restarting Steam, when you try to launch a game, a log named `steam-GAMEID.log` will be saved to your `$HOME` folder.

In my case, the log files said that Steam had no permission to access game files. My laptop has a tiny SDD wherein only the OS and some essential libs are installed, and a large HDD in which heavy files, such as games, are stored. It turns out that this HDD was mounted to a point owned by `root`. Using `chown` to change ownership does not work in this case, since the HDD is formatted in NTFS, and NTFS does not allow fine-grained (folder or file) ownership assignment. Running games directly from the command line via `sudo steam steam://rungameid/{MY_GAME_ID}` does not work either, because Steam will not run anything under `sudo` (it is a terrible idea anyway :)).

It is possible, however, to change the ownership of the entire mounting point. This should be ok if the HDD is not accessed by multiple users, and can be done by changing the `/etc/fstab` file. Find the line referring to the HDD mount and add user/group info. It should look something like this

```
UUID={MY_PARTITION_ID} /hdd ntfs defaults,uid={MY_OWNER_USER},gid={MY_OWNER_GROUP} 0 0
```

A list of all partitions and their UUIDs can be retrieved via `sudo blkid`.

After updating fstab, reboot. Check that HDD ownership was updated and get ready to play.