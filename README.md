# geeper
Backup all git repos every updates

Put a update hook by git template. Push update to another repo which is mirror as well as backup repo.

I use Secure Shell (SSH) protocol for transfering data to backup repo. If you want use another, change `# init remote repo` part of [post-update.sh](./post-update.sh). 
If you replace git template with this file, the script will run before update. (For example, a bare git repository managed by [gogs](https://github.com/gogits/gogs), receive a push will cause a update.) First time, add a remote for current git repo. Later, push update to remote.

## usage

