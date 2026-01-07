cd author
java -Xdebug -Denv -XX:MaxPermSize=256M -Xnoagent -Xms512M -Xmx2048M -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=30403 -jar aem-author-p4502.jar -r author,local -nofork -gui &
#-XX:-UseSplitVerifier