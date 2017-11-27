# write to memcache
for i in {1..20}; 
do 
echo -e "add my_key$i 0 60 11\r\nhello world\r" | nc localhost 11211; 
done

# read from memcache
for i in {1..20}; 
do 
echo -e "get my_key$i\r" | nc localhost 11211
done

# read key which is not present to see get_missed rate

for i in {21..22};
do 
echo -e "get my_key$i\r" | nc localhost 11211
done
