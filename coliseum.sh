
_coliseum () {
# /enterFight
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='27'
	RPER='5'
	ITVL='2.8'
	echo -e "\nColiseum"
	echo $URL
	w3m -debug $ENC $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d"
	SRC=$(w3m -debug -dump_source $ENC $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
	SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
# /wait
	echo " 😴 Waiting..."
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
        EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
#	START=`date +%M`
	while [[ -n $EXIT ]] ; do
#                END=$(expr `date +%M` \- $START)
#                [[ $END -gt 7 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -debug -dump_source $ENC $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=4
	grss=12
	hl=18
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
# /random
		if [[ `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 4 && $hl -lt 18 ]] ; then
			echo '🔁'
			SRC=$(w3m -debug -dump_source $ENC "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /dodge
		elif [[ $ddg -ge 4 && $HP3 -ne $HP1 ]] ; then
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
#			ITVL='1.4'
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
		elif [[ $grss -ge 12 && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
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
# /atk
		else
#		if [[ $ddg -ne 4 || $hl -ne 18 ]] ; then
			echo '🎯'
			SRC=$(w3m -debug -dump_source $ENC "$URL$ATK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
# /view
	echo ""
#	w3m -debug $ENC $URL/coliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | grep --color $ACC
	w3m -debug $ENC $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d"
	echo 'Coliseum (✔)'
	sleep 10
}
