get_colors () {
	# Directory for terminal config
	conf="/home/alana/.config/alacritty/alacritty.yml"
	
	# Toggle the output symbol
	toggle=0

	# Var to store the output string
	out=""

	# Polybar formatting strings
	fstart="%{F#"
	fmid="}"
	fend="%{F-}"

	# Array of color prefixes from the config
	declare -a cols=( "red" "green" "yellow" "blue" "magenta" "cyan" "white" )

	# Pattern to match against (alacritty-specific)
	patt=":\([ ]\+\)[\']0x\([0-9a-zA-Z]\{6\}\)[\']"

	for col in ${cols[@]}; do
		search=$col$patt	
		m=$(grep -m1 "$search" $conf)

		# Split numbers out
		m=${m/*\ \'0x}
		m=${m/\'}

		if [[ $toggle == 0 ]]; then
			out+=$fstart$m$fmid"▲ "$fend
			toggle=1
		else
			out+=$fstart$m$fmid"▼ "$fend
			toggle=0
		fi

	done

	echo $out 

}

get_colors
