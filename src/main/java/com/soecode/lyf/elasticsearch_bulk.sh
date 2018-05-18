#!/bin/sh
#es导入
count=0
rm target.json
touch target.json
while read line;do
((count++))
{
        echo $line >> target.json
        if [ $count -gt 100000 ] && [ $((count%2)) -eq 0 ];then
                count=0
                curl -H "Content-Type: application/json" -XPUT 'http://192.168.5.74:9200/_bulk' --data-binary @target.json > /dev/null
                rm target.json
                touch target.json
        fi
}
done < $1
echo 'last submit'
curl -H "Content-Type: application/json" -XPUT 'http://192.168.5.74:9200/_bulk' --data-binary @target.json > /dev/null