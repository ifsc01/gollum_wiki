# 使用 sameersbn/docker-gitlab 部署gitlab

https://github.com/sameersbn/docker-gitlab#installation

使用compose

```
wget https://raw.githubusercontent.com/sameersbn/docker-gitlab/master/docker-compose.yml
```

aliyun smtp 服务配置

```
    - SMTP_ENABLED=true
    - SMTP_DOMAIN=smtpdm.aliyun.com
    - SMTP_HOST=smtpdm.aliyun.com
    - SMTP_PORT=80
    - SMTP_USER=master@xxx.com
    - SMTP_PASS=passworld
    - SMTP_STARTTLS=false
    - SMTP_AUTHENTICATION=login
```    


## 备份

- GITLAB_BACKUP_SCHEDULE = daily 
- GITLAB_BACKUP_ARCHIVE_PERMISSIONS = 0644 
- GITLAB_BACKUP_DIR = /home/git/data/backups
- GITLAB_BACKUP_TIME=04:00
