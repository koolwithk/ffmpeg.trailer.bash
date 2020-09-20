#env
source env.sh

#check input_path
if [[ $(ls $input_path| wc -l ) == "0" ]]
then
echo "***input directory is empty***"
echo "1.check mount path in docker-compose.yml file***"
echo "2.check mount path and permission***"
exit
fi

#vertical image and pad
bash 1.vertical2h.sh

#img to mp4 converter
bash 2.img2mp4.sh

#select subclip
bash 3.subclip.sh

#fade
bash 4.fade.sh

#check size/audio
bash 5.videofix.sh

#slomotion random
bash 6.slowmo.sh

#concatenate all video
bash 7.concatenate.sh

#add audio
bash 8.audio.sh

#movieeffect
bash 9.movieeffect.sh

