FROM tomcat
COPY ./target/mvn-hello-world.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps/mvn-hello-world.war /usr/local/tomcat/webapps/ROOT.war
RUN mv /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/root2
RUN rm /usr/local/tomcat/webapps/mvn-hello-world.war
EXPOSE 8080
#CMD ["java", "-war","/usr/local/tomcat/webapps/ROOT.war"]
