function videofix() {
  cd $input_path
  rm -rf videofix.*
  list_of_videos=$(ls -ltr | awk '{print $NF}' | grep 'mp4' | grep subclip.mp4)

  for video in $list_of_videos
  do
  #add dummy audio
  audiostatus=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[1].codec_type' | sed 's/"//g')
  if [[ $audiostatus == "audio" ]]
  then
    echo "$video has audio"
  else
    echo "ffmpeg -y -i $video -i ./sample/dummysilence.mp3 -codec copy -shortest videofix.dummy.$video"
    ffmpeg -y -i $video -i ../sample/dummysilence.mp3 -codec copy -shortest videofix.dummy.$video
    mv -v videofix.dummy.$video $video
  fi

  #set video resolution
  height=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[0].height')
  width=$(ffprobe -v quiet -print_format json -show_streams $video | jq '.streams[0].width')
  w=$(echo $scale | cut -d':' -f1)
  h=$(echo $scale | cut -d':' -f2)
  if [[ $width == "$w" ]]
  then
    echo "$video has w=1920"
  else
    echo "ffmpeg -y -i "$video" -filter:v scale="$w":"$h",setdar=16:9,setsar=1:1 -c:a copy videofix.width.$video"
    ffmpeg -y -i "$video" -filter:v scale="$w":"$h",setdar=16:9,setsar=1:1 -c:a copy videofix.width.$video
    mv -v videofix.width.$video $video
  fi

  done

}

videofix