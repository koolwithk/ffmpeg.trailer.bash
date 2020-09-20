function movieeffect(){
  cd $input_path

  #movie filter1
  echo "ffmpeg -y -i fade.mp4 -vf eq=brightness=0.01:contrast=0.9:saturation=1.3 filter.mp4"
  ffmpeg -y -i added_audio.mp4 -vf eq=brightness=0.01:contrast=0.9:saturation=1.3 filter.mp4
  rm -rf added_audio.mp4

  #movie filter2 blackbar
  unixtime=$(date +%s)
  mkdir -p output
  echo "ffmpeg -y -i filter.mp4 -vf  drawbox=x=0:y=0:w=0:h=140:color=black:t=fill,drawbox=x=0:y=940:w=0:h=200:color=black:t=fill ./output/Movietrailer-$unixtime.mp4"
  ffmpeg -y -i filter.mp4 -vf  drawbox=x=0:y=0:w=0:h=140:color=black:t=fill,drawbox=x=0:y=940:w=0:h=200:color=black:t=fill ./output/Movietrailer-$unixtime.mp4
  rm -rf filter.mp4

}
movieeffect