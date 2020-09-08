_clancoliseum () {
# /enterFight
	HPER='49'
	RPER='9'
	ITVL='3.5'
	echo -e "\nClan coliseum"
	echo $URL
	SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC $URL/clancoliseum/?close=reward -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'clancoliseum/enterFight' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = *0 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clancoliseum/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=4
	hl=18
	grss=12
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = *7 ]] && break
# /dodge
		if [[ $hl -ne 18 && $ddg -ge 4 && $HP3 -ne $HP1 ]] ; then
			echo '🛡️'
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
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
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			hl=0
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /grass
		elif [[ $grss -ge 12 && $ddg != [34] && $hl != 1[78] && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
			HPER='30'
			RPER='13'
			echo '🙌'
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			grss=0
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
			echo '💪'
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /random
		elif [[ `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 4 && $hl -ne 18 ]] ; then
			echo '🔁'
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo '🎯'
			SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
# /view
	echo ""
	w3m -debug -o http_proxy="http://$proxy" $ENC $URL/clancoliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	echo "Clan Coliseum (✔)"
	sleep 30
}
