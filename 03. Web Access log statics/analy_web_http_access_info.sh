#! /bin/sh

# total request count by day
total_request_count=0

# total response packet size by day
total_response_packet_size=0

# analize packet size by one file
analy_summary_packet()
{
  echo "filename : $1 "
  # date
  var_dt=$(basename $1 | cut -d'.' -f3)

  # request count
  request_count=0

  # response packet size
  response_packet_size=0
  for ipacket in $(cat $1 | cut -d'"' -f3 | tr ' ' '!' | cut -d'!' -f3 )
  do
#    echo "$ipacket"
    if [ "$ipacket" != "-" ]
    then
      response_packet_size=$(expr "$response_packet_size" + "$ipacket")
      request_count=$(expr "$request_count" + 1)
    fi
  done
  echo "req_date : $var_dt , response_packet_size : $response_packet_size bytes, request_count : $request_count"
  total_response_packet_size=$(expr "$2" + "$response_packet_size")
  total_request_count=$(expr "$3" + "$request_count")
}

# main - search file in current directory
for ix in $(ls `pwd`/access.log.*)
do
  #file only
  if [ -f $ix ]
  then
    analy_summary_packet $ix $total_response_packet_size $total_request_count
    echo "total_response_packet_size : [ $total_response_packet_size ] bytes, total_request_count : [ $total_request_count ] "
  fi
done
