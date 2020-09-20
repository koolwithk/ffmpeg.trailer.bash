function slowmo() {
  cd $input_path
  list_of_videos=$(ls -ltr | awk '{print $NF}' | grep 'mp4' | grep subclip)
  echo "$list_of_videos"
  for video in $list_of_videos
  do
  echo "ffmpeg -y -i $video -filter_complex "[0:v]setpts=2*PTS[v];[0:a]atempo=0.5[a]" -map "[v]" -map "[a]" slow.$video"
  ffmpeg -y -i $video -filter_complex "[0:v]setpts=2*PTS[v];[0:a]atempo=0.5[a]" -map "[v]" -map "[a]" slow.$video
  mv -v slow.$video $video
  done
}

slowmo