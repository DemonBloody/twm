_clancoliseum () {
# /enterFight
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='49'
	RPER='9'
	ITVL='0.9'
	echo -e "\nClan coliseum"
	echo $URL
	SRC=$(w3m -debug -dump_source $ENC $URL/clancoliseum/?close=reward -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'clancoliseum/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = *0 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clancoliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = *7 ]] && break
# /dodge
		[[ $HP3 -ne $HP1 ]] && HP3=$HP1 && echo '🛡️' && \
		SRC=$(w3m -debug -dump_source $ENC "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /attack
		echo '🎯' && \
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
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP3 ]] && echo '🙌' && \
#		SRC=$(w3m -debug -dump_source $ENC "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)") && \
#		_access
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]] && echo '💪' && \
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
	w3m -debug $ENC $URL/clancoliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "Clan Coliseum (✔)"
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	sleep 30
}
