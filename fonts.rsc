# 2020-12-25
#
# http://sdamo.ru
#

/user group add name=fonts policy=local,ftp,read,write,password

/user add name=fonts group=fonts password=password

/ip service
set ftp address=127.0.0.1/32

/system scheduler
add name=SCHEDULE_FONTS on-event="/system script run SCRIPT_FONTS\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup

/system script
add dont-require-permissions=no name=SCRIPT_FONTS owner=sdamo policy=\
    ftp,read,write,test source=":local fontName \"arial\";\r\
    \n\r\
    \n:delay 10;\r\
    \n\r\
    \n/tool fetch mode=ftp upload=no address=127.0.0.1 port=21 user=\"fonts\" pa\
    ssword=\"password\" src-path=\"/fonts/\$fontName.ttf\" dst-path=\"/dude/file\
    s/\$fontName.txt\" keep-result=yes;\r\
    \n\r\
    \n/tool fetch mode=ftp upload=no address=127.0.0.1 port=21 user=\"fonts\" pa\
    ssword=\"password\" src-path=\"/fonts/\$fontName.ttf\" dst-path=\"/dude/file\
    s/\$fontName.ttf\" keep-result=yes;"
