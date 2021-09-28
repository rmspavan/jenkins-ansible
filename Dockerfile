FROM tomcat:latest
# Take the war and copy to webapps of tomcat
COPY ./root/demo/webapp.war /usr/local/tomcat/webapps/
