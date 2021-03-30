#!/usr/bin/env bash

# set -xv
targetDir=$(pwd)
targetDir=./.docker/mysql/initial_data
dia=`date +%Y%m%d`

#Delete old files?
#deleteOldfiles=`find ${targetDir} -type f -mtime +15 -exec ls -l {} \;`
#deleteOldfiles=`find ${targetDir} -type f -mtime +15 -exec rm -f {} \;`
#echo $deleteOldfiles

# hosts=${HOSTNAME}
hosts=docker
port=3306
bancos=gcf
user=gcf
password=Gcf#123

for host in $hosts; do
  #Loop dump mysql
  # rm -rf ${targetDir}/* 2>&1
  for banco in $bancos; do
    echo Backup Atual: $banco
    mysqldump --host=${host} --port=3306 --user=${user} --password=${password} --protocol=tcp --default-character-set=utf8 --single-transaction=TRUE --routines --events --comments --add-drop-database --add-drop-trigger --no-data ${banco} > ${targetDir}/${banco}-${dia}-00-structure-${host}.sql
    # sed -i "s/.*${bancos}.*/&\\n\nCREATE SCHEMA IF NOT EXISTS \`${bancos}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\\nUSE \`${bancos}\`;\\n/" ${targetDir}/${banco}-${dia}-00-structure-${host}.sql
    sed -i "17s/^/&\\nCREATE SCHEMA IF NOT EXISTS \`${bancos}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\\nUSE \`${bancos}\`;\\n/" ${targetDir}/${banco}-${dia}-00-structure-${host}.sql
    mysqldump --host=${host} --port=3306 --user=${user} --password=${password} --protocol=tcp --default-character-set=utf8 --single-transaction=TRUE --routines --events --comments --no-create-info=TRUE ${banco} > ${targetDir}/${banco}-${dia}-01-data-${host}.sql
    # sed -i "s/.*${bancos}.*/&\\n\nUSE \`${bancos}\`;\\n/" ${targetDir}/${banco}-${dia}-01-data-${host}.sql
    sed -i "17s/^/&\\nUSE \`${bancos}\`;\\n/" ${targetDir}/${banco}-${dia}-01-data-${host}.sql
  done
done
# set +xv

exit 0
