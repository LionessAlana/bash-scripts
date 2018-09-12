 
#!/usr/bin/env bash

clip='😂'
echo -n $clip | xclip -selection clipboard
xdotool key Ctrl+v
