_play () {
	_all () {
		_arena
		_campaign
		_career
		_clandungeon
		_trade
		_coliseum
#		_torstop
	}
_crono
# //game time
	if [[ $HOUR -lt 8 || $HOUR -eq 23 ]] ; then
		_all
		_sleep
		_crono
# //Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
#	elif [[ $HOUR -eq 9 && $MIN -ge 45 || $HOUR -eq 15 && $MIN -ge 45 || $HOUR -eq 21 && $MIN -ge 45 ]] ; then
#		while [[ $MIN -ge 50 && $MIN -le 59 ]] ; do
#			echo 'Valley of the Immortals will be started...'
#			if [[ $MIN -ge 59 ]] ; then
#				_sleep
#				_undying
#			fi
#		done
#		_crono
# //Battle of banners 10:15:00 - 16:15:00
#	elif [[ $HOUR -eq 10 && $MIN -gt 10 && $MIN -lt 16 || $HOUR -eq 16 && $MIN -gt 10 && $MIN -lt 16 ]] ; then
#		ts=300
#		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URLhttp/flagfight/enterFight -o user_agent="$(shuf -n1 .ua)")
#		_crono
# //Clan coliseum 10:30:00 - 15:00:00
	elif [[ $HOUR -eq 10 && $MIN -ge 20 && $MIN -lt 31 || $HOUR -eq 14 && $MIN -ge 50 ]] ; then
		while [[ $MIN -ge 20 && $MIN -le 30 || $MIN -ge 50 && $MIN -le 59 ]] ; do
			echo 'Clan coliseum will be started...'
			sleep 30
			_crono
			if [[ $MIN -ge 29 || $MIN -ge 59 ]] ; then
				SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)")
				SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)")
				SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
				ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
				SND1="Enviar"
#//
echo -e "s=$ACCESS&text="`cat << EOF
CDC Ok
EOF`"&send_message=$SND1" >chat.txt
#\\
				SRC=$(w3m -cookie -debug -post chat.txt -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
				_clancoliseum
			fi
		done
		_crono
# //Clan tournament 11:00:00 - 19:00:00
	elif [[ $HOUR -eq 10 && $MIN -ge 50 || $HOUR -eq 18 && $MIN -ge 50 ]] ; then
		while [[ $MIN -ge 50 && $MIN -le 59 ]] ; do
			echo 'Clan tournament will be started...'
			sleep 30
			_crono
			if [[ $MIN -ge 55 ]] ; then
				SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clanfight/enterFight/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
				SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
				ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
				SND1="Enviar"
#//
echo -e "s=$ACCESS&text="`cat << EOF
TC Ok
EOF`"&send_message=$SND1" >chat.txt
#\\
				SRC=$(w3m -cookie -debug -post chat.txt -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
				_clanfight
			fi
		done
		_crono
# //King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
	elif [[ $HOUR -eq 12 && $MIN -ge 20 && $MIN -le 30 || $HOUR -eq 16 && $MIN -ge 20 && $MIN -le 30 || $HOUR -eq 22 && $MIN -ge 20 && $MIN -le 30 ]] ; then
		while [[ $MIN -ge 20 && $MIN -lt 31 ]] ; do
			echo 'King of the Immortals will be started...'
			_sleep
			if [[ $MIN -ge 29 ]] ; then
				_king
			fi
		done
		_crono
# //Ancient Altars 14:00:00 - 21:00:00
	elif [[ $HOUR -eq 13 && $MIN -ge 50 || $HOUR -eq 20 && $MIN -ge 50 ]] ; then
		while [[ $MIN -ge 50 && $MIN -le 55 ]] ; do
			echo 'Ancient Altars will be started...'
			sleep 30
			_crono
		done
		if [[ $MIN -ge 55 ]] ; then
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/altars/enterFight/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
			SND1="Enviar"
#//
echo -e "s=$ACCESS&text="`cat << EOF
Altar Ok
EOF`"&send_message=$SND1" >chat.txt
#\\
			SRC=$(w3m -cookie -debug -post chat.txt -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
			_altars
		fi
		_crono
	else
		_all
		_sleep
		_crono
	fi
}
