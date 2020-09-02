_altars () {
# /enterFight
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='50'
	RPER='9'
	ITVL='2.92'
	echo -e "\nAltars"
	echo $URL
	SRC=$(w3m -debug -dump_source $ENC $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	while [[ -z $EXIT ]] ; do
                [[ $(date +%M) =  {00..09} && $(date +%S) > 19 ]] && break
		echo -e "$URL\n 💤	...\n$ACCESS"
		SRC=$(w3m -debug -dump_source $ENC $URL/altars/?close=reward -o user_agent="$(shuf -n1 .ua)")
		SRC=$(w3m -debug -dump_source $ENC $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/altars/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
                [[ $(date +%M) = {09..10} ]] && break
# /dodge
		if [[ $ddg -ge 4 && $hl -ne 18 && $HP3 -ne $HP1 ]] ; then
			echo '🛡️'
			SRC=$(w3m -debug -dump_source $ENC "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			ddg=0
			HP3=$HP1
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $hl -ge 18 && $HP1 -le $HLHP ]] ; then
			RPER='7'
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -debug -dump_source $ENC "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			hl=0
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /grass
		elif [[ $grss -ge 12 && $ddg -ne "3|4" && $hl -ne "17|18" && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
			HPER='30'
			RPER='13'
			echo '🙌'
			SRC=$(w3m -debug -dump_source $ENC "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			grss=0
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
			echo '💪'
			SRC=$(w3m -debug -dump_source $ENC "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /random
		elif [[ `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 4 && $hl -ne 18 && $grss -ne 12 ]] ; then
			echo '🔁'
			SRC=$(w3m -debug -dump_source $ENC "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo '🎯'
			SRC=$(w3m -debug -dump_source $ENC "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
# /view
	w3m -debug $ENC $URL/altars -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "Altars (✔)"
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	sleep 30
}
