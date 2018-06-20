#!/bin/bash
#yum -y install wget gcc make
#yum -y install openssl openssl-devel
#yum install zlib-devel  bzip2-devel  ncurses-devel sqlite-devel gdbm-devel xz-devel tk-devel readline-devel


#安装 Anaconda 
 yum -y install wget bzip2 screen cifs-utils
 cd ~
 wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
 chmod +x Anaconda3-5.2.0-Linux-x86_64.sh
 ./Anaconda3-5.2.0-Linux-x86_64.sh
 cd ~
 source .bashrc
 source /etc/profile
 conda install -c conda-forge jupyterlab

 #配置jupyter notebook
 cd ~ 
 jupyter notebook --generate-config

 #配置文件位置 /root/.jupyter/jupyter_notebook_config.py

#生成hash-value
#python
##from notebook.auth import passwd
#passwd()
#python -c "import os;from notebook.auth import passwd;os.environ['sha1']=str(passwd());os.system('echo $sha1')"
SHA1=$(python -c "from notebook.auth import passwd;print(passwd())")

cd ~
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout jkey.key -out jcert.pem

#打开配置文件位置 /root/.jupyter/jupyter_notebook_config.py


#egrep "#c.NotebookApp.certfile = ''" /root/.jupyter/jupyter_notebook_config.py

#sed –i.bak 's/#c.NotebookApp.certfile/sunglen#############/' /root/.jupyter/jupyter_notebook_config.py

#sed -n 's/NotebookApp.certfile/sunglen'  /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.certfile = \'\'/c.NotebookApp.certfile = \'~\/jcert.pem\'/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.certfile = \'\'/c.NotebookApp.certfile = \'~\/jcert.pem\'/' /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.keyfile = \'\'/c.NotebookApp.keyfile = \'~\/jkey.key\'/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.keyfile = \'\'/c.NotebookApp.keyfile = \'~\/jkey.key\'/' /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.ip = \'localhost\'/c.NotebookApp.ip = \'*\'/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.ip = \'localhost\'/c.NotebookApp.ip = \'*\'/' /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/' /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.password = \'\'/c.NotebookApp.password = \'sha1:23b8578768a2:a5c5078cd723398750c9bef788afff596e1eb834\'/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.password = \'\'/c.NotebookApp.password = \'sha1:23b8578768a2:a5c5078cd723398750c9bef788afff596e1eb834\'/' /root/.jupyter/jupyter_notebook_config.py

# sed -n $'s/#c.NotebookApp.port = 8888/c.NotebookApp.port = 8080/p' /root/.jupyter/jupyter_notebook_config.py

# sed -i.bak $'s/#c.NotebookApp.port = 8888/c.NotebookApp.port = 8080/' /root/.jupyter/jupyter_notebook_config.py


# c.NotebookApp.certfile = ''
# c.NotebookApp.keyfile = ''
# c.NotebookApp.ip = 'localhost'
# c.NotebookApp.open_browser = True
# c.NotebookApp.password = ''
# c.NotebookApp.port = 8888

#修改参数
echo -e "c.NotebookApp.certfile = '/root/jcert.pem'\nc.NotebookApp.keyfile = '/root/jkey.key'\nc.NotebookApp.ip = '*'\nc.NotebookApp.open_browser = True\nc.NotebookApp.password = '"$SHA1"'\nc.NotebookApp.port = 8080\n " >> /root/.jupyter/jupyter_notebook_config.py



# echo "c.NotebookApp.keyfile = '~/jkey.key'" >> /root/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.password = 'sha1:<your-sha1-hash-value>'" >> /root/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.port = 8888\n alsdfsad fsf" >> /root/.jupyter/jupyter_notebook_config.py
# # for users with root you can use './jcert.pem'
# c.NotebookApp.keyfile = '/home/juser/jkey.key'
# # for users with root you can use './jkey.key'
# c.NotebookApp.ip = '*'
# c.NotebookApp.open_browser = False
# c.NotebookApp.password = 'sha1:<your-sha1-hash-value>'
# c.NotebookApp.port = 8888

#修改防火墙规则
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo systemctl restart firewalld.service

