_king () {
# /enterFight
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='49'
	RPER='1'
	ITVL='0.9'
	echo -e "\nKing"
	echo $URL
	SRC=$(w3m -debug -dump_source $ENC $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M:%S) = 30:15 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	done
# /game
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = 40 ]] && break
# /dodge
		[[ $HP3 -ne $HP1 ]] && HP3=$HP1 && echo '🛡️' && \
		SRC=$(w3m -debug -dump_source $ENC "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /kingatk
		[[ -n $KINGATK ]] && echo '👑' && \
		SRC=$(w3m -debug -dump_source $ENC "$URL$KINGATK" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /attack
		[[ -z $KINGATK ]] && echo '🎯' && \
		SRC=$(w3m -debug -dump_source $ENC "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
		_access
# /heal
		if [[ $HP1 -le $HLHP ]] ; then
			ITVL='1.4'
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -debug -dump_source $ENC "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
		fi
# /grass
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP3 ]] && echo '🙌' && \
#		SRC=$(w3m -debug -dump_source $ENC "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)") && \
#		_access
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || $HP2 -le 15 ]] && echo '💪' && \
#		SRC=$(w3m -debug -dump_source $ENC "$URL$STONE" -o user_agent="$(shuf -n1 .ua)") && \
#		_access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && echo '🔁' && \
		SRC=$(w3m -debug -dump_source $ENC "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)") && \
		_access
		sleep $ITVL
	done
# /view
	echo ""
	w3m -debug $ENC $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "King (✔)"
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	until [[ $(date +%M) = 4[01] ]] ; do
		echo 'Waiting time to go arena...'
		sleep 30
	done
	_AtakeHelp
	_arena
	_AdeleteEnd

}
