_clancoliseum () {
# /enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='49'
	RPER='12'
	ITVL='2.5'
	echo -e "\nClan coliseum"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/clancoliseum/?close=reward -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'clancoliseum/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 15 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clancoliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clancoliseum/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	START=`date +%M`
	until [[ -z $OUTGATE ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 5 ]] && break
# /function random
		_random () {
			sleep $ITVL
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
		}
# /function dodge
		_dodge () {
			sleep $ITVL
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
		}
# /heal
		if [[ $HP1 -lt $HLHP ]] ; then
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			HP1=$HPFULL
			ITVL='2.5'
			sleep $ITVL
			_dodge
			_random
# /random
		elif [[ -n $PRTCT || $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]] ; then
			_random
			_dodge
# /dodge
		else
			_dodge
		fi
	done
# //view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/clancoliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
#	lynx -cfg=~/twm/cfg1 $URL/clancoliseum -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo "Clan coliseum (✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
}
