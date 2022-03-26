#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1


delims = "=", ",", "\n"
regexPattern = '|'.join(map(re.escape, delims))
words = []
freqs = []
with open('shnwiki_wordlist.combined') as fp:
    for line in fp:

        word = re.split(regexPattern, line)[1]
        freq = re.split(regexPattern, line)[3]

        words.append(word)
        freqs.append(int(freq))

with open('shnwiki_wordlist2.combined') as fp:
    for line in fp:

        word = re.split(regexPattern, line)[1]
        freq = re.split(regexPattern, line)[3]
        if word in words:
            try:
                freqs[words.index(word)] = freqs[words.index(word)]+int(freq)
            except:
                continue
        else:
            words.append(word)
            try:
                freqs.append(int(freq)/2)
            except:
                continue

print("finished 2ond wordlist\nsorting the arrays")
freqs, words = zip(*sorted(zip(freqs, words), reverse=True))


print("Now writing the new file")

f = open('new_wiki_wordlist.combined', 'a')

for word, freq in zip(words, freqs):
    f.write(" word="+word+", f="+str(freq)+"\n")

f.close()

print("DONE")

print(file_len("shnwiki_wordlist.combined"), file_len("shnwiki.combined"))
