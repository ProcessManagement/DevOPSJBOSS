Description how to run Vagrant VM and deploy MySQL server and application with "knife".
===============

Software

Host machine:
Linux dirman-ThinkPad-X220 3.19.0-47-generic #53~14.04.1-Ubuntu SMP Mon Jan 18 16:09:14 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Chef Development Kit Version: 0.10.0
chef-client version: 12.5.1
berks version: 4.0.1
kitchen version: 1.4.2

Vagrant install
$ sudo dpkg -i vagrant_1.6.5_x86_64.deb
Vagrant 1.6.5
Install the Vagrant Omnibus plugin to enable Vagrant to install Chef Client on our VM by running the following commands:
$ vagrant plugin install vagrant-omnibus
To view what plugins are installed into our Vagrant environment at any time:
$ vagrant plugin list
vagrant-login (1.0.1, system)
vagrant-omnibus (1.4.1)
vagrant-share (1.1.5, system)

-------------------

Guest virtual machine:
All software will be install automaticaly from Vagrantfile file and after knife bootstrap commands.

===============

Run Vagrant VM

Create new dir in your ~ 
$cd ~
$mkdir epam-project/
Then execute vagrant command:
~/epam-project$vagrant init
Put here Vagrantfile file from github repository https://github.com/Serge-Minsk/Chef-project/:
Then execute vagrant command and you will see log below:
~/epam-project$VAGRANT_LOG=info vagrant up
Finally you can check port 2222 on you localhost:
~/epam-project$ curl 127.0.0.1:2222
SSH-2.0-OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.3

It's you VM.

===============

Deploy MySQL and Jboos6.0.0 on server and application with "knife"

I use hosted chef server(https://manage.chef.io/login)
I already unzip chef-starter.zip file to ~ dir.

Copy all files from github repository https://github.com/Serge-Minsk/Chef-project/ to your ~/chef-repo dir.
Then execute chef commands in your :~/chef-repo dir:
:~/chef-repo$knife environment from file ~/chef-repo/environments/development.json
:~/chef-repo$knife cookbook upload -a
:~/chef-repo$knife role from file ~/chef-repo/roles/Jboss.json
:~/chef-repo$knife role from file ~/chef-repo/roles/Mysql.json
Check that all executed successfully.

Then execute chef command in your :~/chef-repo dir:
:~/chef-repo$ knife bootstrap 127.0.0.1:2222 --ssh-user vagrant --ssh-password vagrant --sudo --use-sudo-password --node-name server --run-list 'role[Mysql]'
Check that all executed successfully.

Then execute second chef command in your :~/chef-repo dir:
knife bootstrap 127.0.0.1:2222 --ssh-user vagrant --ssh-password vagrant --sudo --use-sudo-password --node-name server --run-list 'role[JBOSS]'

Finally you can check you application on port 8888 on you localhost:
~/chef-repo$ curl 127.0.0.1:8888/guestbookapp/
Or just check url 127.0.0.1:8888/guestbookapp/ in your browser.
Thanks

