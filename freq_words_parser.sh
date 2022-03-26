cat shnwiki.txt | tail -n +2 | awk '{print " word="$1", f="$2}' > shnwiki.combined
# unix timestamp
date +%s
