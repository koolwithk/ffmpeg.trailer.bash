function subclip() {
  cd $input_path
  list_of_videos=$(ls -lt | awk '{print $NF}' | egrep 'mp4|MP4')
  vcount=1

  for video in $list_of_videos
  do
  #randomstart=$(awk "BEGIN {print 0.5+0.$RANDOM; exit}")
  #height=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[0].height')
  #width=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[0].width')
  duration=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[0].duration' | sed 's/"//g')
  echo $duration
  duration=$(echo $duration | cut -d '.' -f1)

  if (( "$duration" < 3 ))
  then
    randomstart=0
    randomlen=$(awk "BEGIN {print 1+0.$RANDOM; exit}")
  else
    randomstart=$(awk "BEGIN{srand();print int(rand()*(1-$duration))+$duration}")
    randomlen=$(awk "BEGIN {print 2+0.$RANDOM; exit}")
  fi
  
  echo "ffmpeg -y -i $video -r 24 -ss $randomstart -t $randomlen -async 1 $vcount.subclip.mp4"
  ffmpeg -y -i $video -r 24 -ss $randomstart -t $randomlen -async 1 $vcount.subclip.mp4
  vcount=$(($vcount+1))
  done

  rm -rf img2mp4.*

}

subclip