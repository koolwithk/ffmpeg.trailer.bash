function fade() {
  cd $input_path

  subclip_count=$(ls -ltr | awk '{print $NF}' | grep 'subclip.mp4' | wc -l)

  #fade in
  fade_in_video=$(ls -ltr | awk '{print $NF}' | grep 'subclip' | sed -n 1p)
  fade_in_video="1.subclip.mp4"
  echo "$fade_in_video"
  echo "ffmpeg -y -i $fade_in_video  -vf fade=in:st=0:d=2 fade_in.$fade_in_video"
  ffmpeg -y -i $fade_in_video -vf fade=in:st=0:d=2 fade_in.$fade_in_video
  mv -v fade_in.$fade_in_video $fade_in_video
  

  #fade out
  fade_out_video=$(ls -ltr | awk '{print $NF}' | grep 'subclip' | sed 'x;$!d')
  fade_out_video="$subclip_count.subclip.mp4"
  echo "$fade_out_video"
  echo "ffmpeg -y  -i $fade_out_video -vf fade=out:st=0:d=2 fade_out.$fade_out_video"
  ffmpeg -y -i $fade_out_video -vf fade=out:st=0:d=2 fade_out.$fade_out_video
  mv -v fade_out.$fade_out_video $fade_out_video

}

fade