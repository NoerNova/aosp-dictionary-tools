#!/usr/bin/perl

# remove myanmar words
$/ = "/\n";                     # input record separator

while (<>) {

    s/^.*word=.*[က-ဃ].*//g; # skip င
    s/^.*word=.*[စ-ဏ].*//g; # skip တ ထ
    s/^.*word=.*[ဒ-န].*//g; # skip ပ ဖ
    s/^.*word=.*[ဗ-ဘ].*//g; # skip မ ရ လ ဝ သ
    s/^.*word=.*[ဟ-အ].*//g; # skip ဢ
    s/^.*word=.*[ဣ-ာ].*//g; # skip ိ  ီ ု ူ ေ 
    s/^.*word=.*[ဲ-ဴ].*//g; # skip ဵ ံ ့ း
    s/^.*word=.*[္].*//g; # skip ် ျ ြ ွ
    s/^.*word=.*[ှ-၉].*//g; # skip ၊ ။
    s/^.*word=.*[၌-ၡ].*//g; # skip ၢ
    s/^.*word=.*[ၣ-ၴ].*//g; # skip ၵ ၶ ၷ ၸ ၹ ၺ ၻ ၼ ၽ ၾ ႀ ႁ ႂ ႃ ႄ ႅ ႆ ႇ ႈ ႉ ႊ ႋ ႌ ႍ ႎ ႏ ႐ ႑ ႒ ႓ ႔ ႕ ႖ ႗ ႘ ႙ ႚ ႛ ႜ ႝ ႞ ႟

    s/^.{35,}//; # remove long words
    s/\b\s+\b //; # remove multiple spaces

    chomp;
    print $_;
}