

# Welcome to the project wiki

# H1

## H2

### H3

**Bold**
*Italics*
~~Strike~~

`Code code code`

> Quote

* List1
* List2

1. ListA
1. ListB


[Link](http://p.com)


| Column 1 | Column 2 | Column 3 |
| -------- | -------- | -------- |
| Text     | Text     | Text     |

Rule


-----

	

'sudo parted /dev/disk/by-id/scsi-0DO_Volume_volume-nyc3-01 mklabel gpt
sudo parted -a opt /dev/disk/by-id/scsi-0DO_Volume_volume-nyc3-01 mkpart primary ext4 0% 100%
sudo mkfs.ext4 /dev/disk/by-id/scsi-0DO_Volume_volume-nyc3-01-part1
sudo mkdir -p /mnt/volume-nyc3-01-part1
echo '/dev/disk/by-id/scsi-0DO_Volume_volume-nyc3-01-part1 /mnt/volume-nyc3-01-part1 ext4 defaults,nofail,discard 0 2' | sudo tee -a /etc/fstab
sudo mount -a
findmnt /mnt/volume-nyc3-01-part1'


echo 'success' | sudo tee /mnt/volume-nyc3-01-part1/test_file
cat /mnt/volume-nyc3-01-part1/test_file
sudo rm /mnt/volume-nyc3-01-part1/test_file
sudo lsof +f -- /mnt/volume-nyc3-01-part1


ln -s /mnt/volume-nyc3-01-part1/git /home/git/git 

wget -O gitea https://dl.gitea.io/gitea/1.3.2/gitea-1.3.2-linux-amd64 
chmod +x gitea
sudo nano /etc/systemd/system/gitea.service

[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target
#After=mysqld.service
#After=postgresql.service
#After=memcached.service
#After=redis.service

[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/home/git/git/gitea
ExecStart=/home/git/git/gitea web
Restart=always
Environment=USER=git HOME=/home/git/git

[Install]
WantedBy=multi-user.target



sudo systemctl start gitea
sudo systemctl enable gitea
sudo service gitea start
sudo service gitea status


sudo nano /etc/nginx/sites-available/fluidgrid.xyz.vhost


server {
listen 80;
server_name fluidgrid.xyz;
location / {
proxy_pass http://fluidgrid.xyz:3000;
}
}

sudo ln -s /etc/nginx/sites-available/fluidgrid.xyz.vhost /etc/nginx/sites-enabled/

sudo service nginx restart

systemctl reload nginx
service nginx stop
service gitea stop
service gitea start
service nginx start

apt install software-properties-common 
add-apt-repository ppa:certbot/certbot
apt update
apt install python-certbot-nginx

sudo certbot --nginx
option 2 - auto


sudo nano /home/git/git/custom/conf/app.ini

ROOT_URL = https://fluidgrid.xyz

