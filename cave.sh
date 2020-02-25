# /cave
function _cave () {
	_clanid
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
	_condition () {
		ACCESS1=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | cut -d\' -f2)
		DOWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/down' | cut -d\' -f2)
		ACCESS2=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2)
		ACTION=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | cut -d\' -f2 | tr -cd "[[:alpha:]]")
	}
	_condition
	num=8
	until [[ $num -eq 0 ]]; do
		SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr|cavespeedUpr)
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
			num=$[$num-1] ;
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)") ;
			echo $num ;;
			(caveattackrcaverunawayr)
			num=$[$num-1] ;
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)") ;
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)") ;
			echo $num ;;
		esac
		echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2
	done
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	echo -e "cave (✔)\n"
}
