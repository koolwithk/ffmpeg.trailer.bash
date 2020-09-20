function audio() {
  cd $input_path

  #audio gain on concatenate -15db
  echo "ffmpeg -y -i concatenate.mp4 -vcodec copy -af "volume=-15dB" audiogain.mp4"
  ffmpeg -y -i concatenate.mp4 -vcodec copy -af "volume=-15dB" audiogain.mp4
  rm -rf concatenate.mp4

  #add background song
  song=$(ls -ltr | awk '{print $NF}' | grep '.mp3' | sed -n 1p)
  if [[ $song == "" ]]
  then
    echo "ffmpeg -y -i "../sample/dummysong.mp3" -i audiogain.mp4 -filter_complex "[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]" -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4"
    ffmpeg -y -i "../sample/dummysong.mp3" -i audiogain.mp4 -filter_complex "[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]" -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4
  else
    echo "ffmpeg -y -i "$song" -i audiogain.mp4 -filter_complex "[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]" -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4"
    ffmpeg -y -i "$song" -i audiogain.mp4 -filter_complex "[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]" -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4
  fi
  rm -rf audiogain.mp4
  #audio fade_in and fade_out
  
}

audio