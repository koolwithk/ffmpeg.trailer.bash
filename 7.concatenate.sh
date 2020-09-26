function concatenate() {
  cd $input_path
  list_of_videos=$(ls -l | awk '{print $NF}' | grep 'mp4' | grep subclip | sort -n) #sort -n to get the subclip in order
  count_vidoes=$(ls -ltr | awk '{print $NF}' | grep 'mp4' | grep subclip | wc -l)
  
  #input parameter for concatenate filter_complex
  input_p1=""
  input_p2=""
  for i in $list_of_videos
  do
  input_p1=$i
  input_p2+=" -i $input_p1"
  done

  #filter_complex parameter
  filter_complex_p1=""
  filter_complex_p2=""
  for number in $(seq 0 $(($count_vidoes-1)))
  do
  filter_complex_p1="[$number:v] [$number:a]"
  filter_complex_p2+="$filter_complex_p1 "
  done

  #concatenate all vidoes
  echo "ffmpeg -y "$input_p2" -filter_complex "\"$filter_complex_p2 concat=n="$count_vidoes":v=1:a=1 [v] [a]"\" -map "[v]" -map "[a]" concatenate.mp4"
  echo "ffmpeg -y "$input_p2" -filter_complex "\"$filter_complex_p2 concat=n="$count_vidoes":v=1:a=1 [v] [a]"\" -map "[v]" -map "[a]" concatenate.mp4" > concatenate.sh
  bash concatenate.sh
  rm -rf concatenate.sh

  #ffmpeg -y "$input_p2" -filter_complex \""$filter_complex_p2 concat=n="$count_vidoes":v=1:a=1 [v] [a]"\" -map "[v]" -map "[a]" concatenate.mp4
  rm -rf *.subclip.mp4
}

concatenate