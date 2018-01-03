# geeper
Backup all git repos every updates

Put a update hook by git template. Push update to another repo which is mirror as well as backup repo.

I use Secure Shell (SSH) protocol for transfering data to backup repo. If you want use another, change `# init remote repo` part of [post-update.sh](./post-update.sh). 
If you replace git template with this file, the script will run before update. (For example, a bare git repository managed by [gogs](https://github.com/gogits/gogs), receive a push will cause a update.) First time, add a remote for current git repo. Later, push update to remote.

## usage

Setting for existed gogs.

1. Run a sshd docker container. You can use this docker file [Dockerfile](./sshdDockerfile/Dockerfile). Generate a key pair to ssh login this sshd container.
1. Copy the key file generated before to gogs containers `~/.ssh/`. Copy [config](./config) to gogs containers `~/.ssh/`. Replace sshd's address, port, key file name in `config`. You can have a try, to insure ssh login without passwd.
1. Copy [post-update.sh](./post-update.sh) to gogs containers `/usr/share/git-core/templates/hooks/post-update`(file, not folder)
1. New a repo through gogs, then push something. You will find a repo with the update in sshd container's `/tmp/repos`.
1. Run [walk.sh](./walk.sh) with a parameter, top folder of all repos managed by gogs. All repos will have the hook `post-update`.