#!/usr/bin/perl

# Program to filter Wikipedia XML dumps to "clean" text consisting only of lowercase
# letters (a-z, converted from A-Z), and spaces (never consecutive).  
# All other characters are converted to spaces.  Only text which normally appears 
# in the web browser is displayed.  Tables are removed.  Image captions are 
# preserved.  Links are converted to normal text.  Digits are spelled out.

# Written by Matt Mahoney, June 10, 2006.  This program is released to the public domain.
# Modified by NoerNova, March 28, 2022. To used with Shan language version wiki.

$/=">";                     # input record separator
while (<>) {
  if (/<text /) {$text=1;}  # remove all but between <text> ... </text>
  if (/#redirect/i) {$text=0;}  # remove #REDIRECT
  if ($text) {

    # Remove any text not normally visible
    if (/<\/text>/) {$text=0;}
    s/<.*>//;               # remove xml tags
    s/&amp;/&/g;            # decode URL encoded chars
    s/&lt;/</g;
    s/&gt;/>/g;
    s/<ref[^<]*<\/ref>//g;  # remove references <ref...> ... </ref>
    s/<[^>]*>//g;           # remove xhtml tags
    s/\[http:[^] ]*/[/g;    # remove normal url, preserve visible text
    s/\|thumb//ig;          # remove images links, preserve caption
    s/\|left//ig;
    s/\|right//ig;
    s/\|\d+px//ig;
    s/\[\[image:[^\[\]]*\|//ig;
    s/\[\[category:([^|\]]*)[^]]*\]\]/[[$1]]/ig;  # show categories without markup
    s/\[\[[a-z\-]*:[^\]]*\]\]//g;  # remove links to other languages
    s/\[\[[^\|\]]*\|/[[/g;  # remove wiki url, preserve visible text
    s/\{\{[^\}]*\}\}//g;         # remove {{icons}} and {tables}
    s/\{[^\}]*\}//g;
    s/\[//g;                # remove [ and ]
    s/\]//g;
    s/\{//g;                # remove { and }
    s/\}//g;
    s/&[^;]*;/ /g;          # remove URL encoded chars
    s/\w/ /g;               # remove english, thai, other ascii supported words/characters
    s/\n\s*/\n/g;           # remove empty line

    # convert to lowercase letters and spaces, spell digits
    $_=" $_ ";
    s/0/ သုၼ် /g;
    s/1/ ၼိုင်ႈ /g;
    s/2/ သွင် /g;
    s/3/ သၢမ် /g;
    s/4/ သီႇ /g;
    s/5/ ႁႃႈ /g;
    s/6/ ႁူၵ်း /g;
    s/7/ ၸဵတ်း /g;
    s/8/ ပႅတ်ႇ /g;
    s/9/ ၵဝ်ႈ /g;
    chop;
    print $_;
  }
}
