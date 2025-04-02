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

## Bonus Task A 
* Add email notification using mail or ssmtp when change is detected

### Prerequisites
* Install ssmtp and mailutils packages
```` sudo apt install ssmtp && sudo apt install mailutils ````

