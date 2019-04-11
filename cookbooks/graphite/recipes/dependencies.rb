apt_update 'apt_update' do
  ignore_failure true
  action :update
end

apt_package %w(graphite-web graphite-carbon mysql-server python-mysqldb python-pymysql apache2 libapache2-mod-wsgi python-pip) do
  action :install
end

template 'etc/graphite/local_settings.py' do
  source 'local_settings.py.rb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute 'create_user' do
  command "mysql -u root -e \"CREATE USER 'graphite'@'localhost' IDENTIFIED BY 'password';\""
  action :run
  not_if 'mysql -u root -e "select user from mysql.user;" | grep graphite'
end

execute 'create_db' do
  command "mysql -u root -e \"CREATE DATABASE IF NOT EXISTS graphite DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;\""
  action :run
  not_if 'mysql -u root -e "show databases;" | grep graphite'
end

execute 'privileges_db' do
  command "mysql -u root -e \"GRANT ALL PRIVILEGES ON graphite.* TO 'graphite'@'localhost';\""
  action :run
end


execute 'change_secret_key' do
  command 'sed -i "s/UNSAFE_DEFAULT/$(date | md5sum | cut -d " " -f 1)/" /etc/graphite/local_settings.py'
  action :run
  only_if "cat /etc/graphite/local_settings.py | grep UNSAFE_DEFAULT"
end

template '/etc/default/graphite-carbon' do
  source 'graphite-carbon.rb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/default/storage-schemas.conf' do
  source 'storage-schemas.conf.rb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template 'etc/apache2/sites-available/apache2-graphite.conf' do
  source 'apache2-graphite.conf.rb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/apache2/ports.conf' do
  source 'ports.conf.rb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute 'disable apache server 000-default ' do
  command 'a2dissite 000-default'
  action :run
end

execute 'enable apache server apache2-graphite' do
  command 'a2ensite apache2-graphite'
  action :run
end

execute 'graphite_syncdb' do
  command 'graphite-manage syncdb --noinput'
  action :run
end


service 'carbon-cache' do
  action :start
end

service 'apache2' do
  action :restart
end