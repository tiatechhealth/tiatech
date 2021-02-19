#!/bin/bash
### Basic Settings ###
TAR=`which tar`
NOW=`date +%F`
TIME=`date +"%H-%M"`
GZIP=`which gzip`
HOST=`hostname`
RM=`which rm`
MAIL=`which mail`
SOURCE=$@
REST="0"

## Backup Directories ##
DIST_DIR='/data1/db_backup'
backup_dir="${DIST_DIR}/${SOURCE}"

WEIGHT=90

##Logs ##
ACTIVITYLOG=/tmp/backup-active.log
ERRORLOG=/tmp/backup-error.log
##Email Configuration ##
Email='sysadmin@tiatech.net'
Email_Content="/tmp/email_file"



Email_note (){
echo ""
echo ""
echo ""
echo "Note : System generated email please do not reply, for further enquiries contact System Administrator. "
}

usage() {
 echo " Input error, please follow the instructions below"
 echo ""
 echo "This  is the custom script written for backup web and dababase environment"
 echo "to maintain 30 cycles, if you need to change the cycles edit DEGREE value."
 echo "Enter valid input as daily , monthly , weekly and set crone."
 echo "@Daily Backup : @daily /path/to/script.sh daily"
 echo "@weekly Backup : @weekly /path/to/script.sh weekly"
 echo "@Monthly Backup : @monthly /path/to/script.sh monthly"
}

Dir_check() {
[ ! -f ${Email_Content} ] && touch ${Email_Content} || :> ${Email_Content}
for i  in $SOURCE
do
if [ $SOURCE != "daily" -a $SOURCE != "monthly" -a $SOURCE != "weekly" ];then
        usage >> ${Email_Content}
        E_mail Failed
        exit 1
else
echo "Matching input data $SOURCE" >> ${Email_Content}
        if [ ! -d "$DIST_DIR/$i" ]; then
                echo "Backup dir not exist Creating dir $DIST_DIR/$i" >> ${Email_Content}
                mkdir -p "${backup_dir}"
                chmod 700 "${backup_dir}"
        else
                echo "Backup directory exist, perparing for backup $DIST_DIR/$i " >> ${Email_Content}
                mkdir -p "${backup_dir}"
                chmod 700 "${backup_dir}"
        fi
fi
  echo "Backup directory: ${backup_dir}" >> ${Email_Content}
done
}

E_mail(){
        Email_note  >> $Email_Content
        for i in $Email
        do
        cat $Email_Content | $MAIL -s "Notification: Backup $1 from RenaiServer-Stat: $SOURCE" \
           -S from="backupadmin@tiatech.net(TiatechBackup)" \
           $i
        done
}


Dir_check >> ${Email_Content}
