node.default['ssh']['user'] = 'vagrant'
#You can add a variety of tags, including the name 
# of the image the container is running from and any labels 
# applied to the container. The field is a Go template 
# and has access to everything in the logging context.
# https://docs.docker.com/config/containers/logging/log_tags/
node.default['docker']['tags'] = "{{.ImageName}}/{{.Name}}/{{.ID}}"
node.default['logstash']['address'] = "tcp://10.20.0.8:5514"
