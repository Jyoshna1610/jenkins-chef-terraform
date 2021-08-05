package 'httpd' do
action :install
end

 

file '/var/www/html/index.html' do
content 'Welcome to chef'
action :create
end

 


service 'httpd' do
action [:enable, :start]
end
