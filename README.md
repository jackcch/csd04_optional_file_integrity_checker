# CSD04 optional project - File integrity Checker

## Task A – Script Development
* Write a bash script that stores initial file hashes
* On re-run, compares hashes and logs discrepancies


| File                               | Description                                                                                                        |
|------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [monitorshell.sh](filecheck/monitorshell.sh)                    | Monitoring shell script to be executed via cronjob                                                                 |
| monitorfiles.txt                   | List of files to be monitored - to be included as argument when calling monitoring.sh                              |
| emailreceiver.txt                  | List of email alert recipients                                                                                     |
| emailtemplate.txt                  | Default Email Template                                                                                             |
| monitor.db                         | List of monitored files and last captured hash value                                                               |

## Task B: Automation and Logging
* Setup cron job to run every 15 mins
* Create a /var/log/integrity.log file
* Use chmod/chown for log file security

Crontab setup job to run at every 15 mins interval

```
*/15 * * * * ~/scripts/filecheck/monitorshell.sh monitorfiles.txt
```

## Bonus Task A 
* Add email notification using mail or ssmtp when change is detected

### Prerequisites
* Install ssmtp and mailutils packages
```` sudo apt install ssmtp && sudo apt install mailutils ````

### Configuration
- Configure files to be monitored in monitorfiles.txt
```
/etc/ssh/sshd_config
/etc/passwd
/etc/group
/etc/somefiles
```

- Configure email recipients in emailreceiver.txt
```
john@me.com
mister@abc.com
```

- Configure email template in emailtemplate.txt
```
Subject: Alert! - A sensitive file has been changed

A file was changed 

```

### Hash value table captured for checking changes/modifications

~/scripts/filecheck/monitor.db

```
9ce65293b15513398541fad559786ef310a9045bdda398005477fda6ebf3c0f0  /etc/ssh/sshd_config
7921708e98fb1fb1cb69203d02e1eb889db1dfeeb75fae802722afa06bad1b2a  /etc/passwd
b7aca1386c9da114613d7533c696d40a0ec56d0f51b04280ea82b6b05904a802  /etc/group

```

### Sample Logs generated

/var/log/integrity.log

```
2025-04-02 11:15:01 - No Changes Detected
2025-04-02 11:15:01 - *----File Integrity Check Service Ended
2025-04-02 11:30:01 - *---File Integrity Check service started for
2025-04-02 11:30:01 - No Changes Detected
2025-04-02 11:30:01 - *----File Integrity Check Service Ended
2025-04-02 11:45:01 - *---File Integrity Check service started for
2025-04-02 11:45:01 - No Changes Detected
2025-04-02 11:45:01 - *----File Integrity Check Service Ended
2025-04-02 11:48:01 - *---File Integrity Check service started for
2025-04-02 11:48:01 - No Changes Detected
2025-04-02 11:48:01 - *----File Integrity Check Service Ended
2025-04-02 11:50:01 - *---File Integrity Check service started for
2025-04-02 11:50:01 - No Changes Detected
2025-04-02 11:50:01 - *----File Integrity Check Service Ended
2025-04-02 12:00:01 - *---File Integrity Check service started for monitorfiles.txt
2025-04-02 12:00:01 - 9ce65293b15513398541fad559786ef310a9045bdda398005477fda6ebf3c0f0
2025-04-02 12:00:01 - 9ce65293b15513398541fad559786ef310a9045bdda398005477fda6ebf3c0f0
2025-04-02 12:00:01 - /etc/ssh/sshd_config
2025-04-02 12:00:01 - 7921708e98fb1fb1cb69203d02e1eb889db1dfeeb75fae802722afa06bad1b2a
2025-04-02 12:00:01 - 344bb41e22c3c7123fd2b6eb3bbabb313a6a130e302c123065aa42c563fea830
2025-04-02 12:00:01 - /etc/passwd
2025-04-02 12:00:01 - File /etc/passwd has been changed
2025-04-02 12:00:01 - OldHash: 344bb41e22c3c7123fd2b6eb3bbabb313a6a130e302c123065aa42c563fea830
2025-04-02 12:00:01 - NewHash: 7921708e98fb1fb1cb69203d02e1eb889db1dfeeb75fae802722afa06bad1b2a
2025-04-02 12:00:01 - New Hash updated
2025-04-02 12:00:04 - Email notification sent to jackchow30@me.com
2025-04-02 12:00:06 - Email notification sent to jackcch8773@gmail.com
2025-04-02 12:00:06 - b7aca1386c9da114613d7533c696d40a0ec56d0f51b04280ea82b6b05904a802
2025-04-02 12:00:06 - 84a686124b14653e4bfaeedf147b8eb8e4bff337d8a8dc141682da55c8281d12
2025-04-02 12:00:06 - /etc/group
2025-04-02 12:00:06 - File /etc/group has been changed
2025-04-02 12:00:06 - OldHash: 84a686124b14653e4bfaeedf147b8eb8e4bff337d8a8dc141682da55c8281d12
2025-04-02 12:00:06 - NewHash: b7aca1386c9da114613d7533c696d40a0ec56d0f51b04280ea82b6b05904a802
2025-04-02 12:00:06 - New Hash updated
2025-04-02 12:00:08 - Email notification sent to john@me.com
2025-04-02 12:00:11 - Email notification sent to mister@abc.com
```