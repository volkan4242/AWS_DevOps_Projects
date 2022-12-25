#!/bin/bash

# Check if we are root privilage or not
if [[ ${UID} -ne 0 ]]
then
   echo "Please use this bash script with root privilage"
   exit 1
fi

# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
backup_files="/home/ec2-user/data /etc /boot /opt" 

# Where do we backup to. Please crete this file before execute this script
dest="/mnt/backup"

# Create archive filename based on time
time=$(date +"%Y_%m_%d_%I_%M_%p")
hostname=$(hostname -s)
archive_file="${hostname}-${time}.tgz"

# Print start status message.
echo "We will back up ${backup_files} to ${dest}/${archive_file} "
date
echo

# Backup the files using tar.
tar czf ${dest}/${archive_file} ${backup_files} # &> /dev/null (Bunu script birkaç kez calistirilip eklenebilir)

# Print end status message.
echo
echo "Congrulations! Your Backup is ready"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

-------------

# To set this script for executing in every 5 minutes, we'll create cronjob
```bash
crontab -e
```
- vi or nano editor will open. We will run  backup.sh script in every 5 minutes. To be able to do this we\'ll write this within opend vi or nano file

```bash
*/5 * * * * sudo /home/ec2-user/backup.sh
```

- save and exit from nano or vi

- To check whether your Cron Jobs is saved or not, run the below command.
```bash
$crontab -l
```

This part is so important:

Once an archive has been created it is important to test the archive. The archive can be tested by listing the files it contains, but the best test is to restore a file from the archive.

To see a listing of the archive contents. From a terminal prompt type:

```bash
tar -tzvf /mnt/backup/ip-172-31-89-147-2021_11_02_12_26_AM.tgz
```

To restore a file from the archive to a different directory enter:

```bash
tar -xzvf /mnt/backup/ip-172-31-89-147-2021_11_02_12_26_AM.tgz -C /tmp etc/hosts
```

The -C option to tar redirects the extracted files to the specified directory. The above example will extract the etc/hosts file to /tmp/etc/hosts. tar recreates the directory structure that it contains.

Also, notice the leading “/” is left off the path of the file to restore.

To restore all files in the archive enter the following:

```bash
cd /
sudo tar -xzvf /mnt/backup/ip-172-31-89-147-2021_11_02_12_26_AM.tgz
```

Note: 

This will overwrite the files currently on the file system.